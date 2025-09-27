#!/usr/bin/env python3
"""
プロジェクトファイルにAssets.xcassetsを安全に追加するスクリプト
"""

import re
import uuid
import sys
import os

def add_assets_to_project(project_path):
    """project.pbxprojにAssets.xcassetsを追加"""

    if not os.path.exists(project_path):
        print(f"Error: Project file not found: {project_path}")
        return False

    # ファイルを読み込み
    with open(project_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 新しいUUIDを生成
    assets_file_ref_id = str(uuid.uuid4()).replace('-', '').upper()[:24]
    assets_build_file_id = str(uuid.uuid4()).replace('-', '').upper()[:24]

    # 1. PBXBuildFileセクションにAssets.xcassetsのビルドファイルを追加
    build_file_pattern = r'(/\* Begin PBXBuildFile section \*/\n)'
    assets_build_file = f'\t\t{assets_build_file_id} /* Assets.xcassets in Resources */ = {{isa = PBXBuildFile; fileRef = {assets_file_ref_id} /* Assets.xcassets */; }};\n'

    if assets_build_file_id not in content:
        content = re.sub(build_file_pattern, r'\1' + assets_build_file, content, count=1)
        print(f"Added PBXBuildFile entry: {assets_build_file_id}")

    # 2. PBXFileReferenceセクションにAssets.xcassetsのファイル参照を追加
    file_ref_pattern = r'(/\* Begin PBXFileReference section \*/\n)'
    assets_file_ref = f'\t\t{assets_file_ref_id} /* Assets.xcassets */ = {{isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Resources/Assets.xcassets; sourceTree = SOURCE_ROOT; }};\n'

    if assets_file_ref_id not in content:
        content = re.sub(file_ref_pattern, r'\1' + assets_file_ref, content, count=1)
        print(f"Added PBXFileReference entry: {assets_file_ref_id}")

    # 3. PBXResourcesBuildPhaseにAssets.xcassetsを追加
    resources_pattern = r'(/\* Begin PBXResourcesBuildPhase section \*/.*?files = \(\n)(.*?)(\s*\);)'

    def add_to_resources(match):
        begin = match.group(1)
        files_content = match.group(2)
        end = match.group(3)

        # 既にAssets.xcassetsが含まれているかチェック
        if assets_build_file_id not in files_content:
            assets_resource_entry = f'\t\t\t\t{assets_build_file_id} /* Assets.xcassets in Resources */,\n'
            files_content += assets_resource_entry
            print(f"Added to PBXResourcesBuildPhase: {assets_build_file_id}")

        return begin + files_content + end

    content = re.sub(resources_pattern, add_to_resources, content, flags=re.DOTALL)

    # 4. PBXGroupのResourcesグループにAssets.xcassetsを追加
    # まず、Resourcesグループを見つける
    resources_group_pattern = r'(/\* Resources \*/ = \{.*?children = \(\n)(.*?)(\s*\);)'

    def add_to_resources_group(match):
        begin = match.group(1)
        children_content = match.group(2)
        end = match.group(3)

        # 既にAssets.xcassetsが含まれているかチェック
        if assets_file_ref_id not in children_content:
            assets_group_entry = f'\t\t\t\t{assets_file_ref_id} /* Assets.xcassets */,\n'
            children_content += assets_group_entry
            print(f"Added to Resources PBXGroup: {assets_file_ref_id}")

        return begin + children_content + end

    content = re.sub(resources_group_pattern, add_to_resources_group, content, flags=re.DOTALL)

    # ファイルに書き込み
    with open(project_path, 'w', encoding='utf-8') as f:
        f.write(content)

    print("Assets.xcassets successfully added to project.pbxproj")
    return True

if __name__ == "__main__":
    project_path = "/Users/kukkiiboy/Desktop/Claudecode/0926クイズ反映テストキラキラ/hukusijuukankyou2kyuu/福祉住環境コーディネーター2級.xcodeproj/project.pbxproj"

    success = add_assets_to_project(project_path)

    if success:
        print("Script completed successfully")
        sys.exit(0)
    else:
        print("Script failed")
        sys.exit(1)