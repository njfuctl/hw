#!/usr/bin/env bats

# 检查 journal.log 文件是否存在
@test "检查 journal.log 文件" {
    [ -f "journal.log" ]
}

# 测试主脚本是否能够无错误运行
@test "运行主脚本" {
    run ./5.sh
    [ "$status" -eq 0 ]
}

# 测试主脚本是否生成有效的输出
@test "检查脚本输出" {
    run ./5.sh
    [ "$output" != "" ]
}

# 测试脚本是否正确计算平均启动时间
@test "计算平均启动时间" {
    run ./5.sh
    [ "$output" != "" ] 
    echo "$output" | grep -q "Average Boot Time"

}
