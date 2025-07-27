-- 更新tasks表，添加实时进度和日志字段
USE llm_mapreduce;

-- 添加进度百分比字段
ALTER TABLE tasks ADD COLUMN progress_percentage INT NOT NULL DEFAULT 0 COMMENT '任务进度百分比(0-100)';

-- 添加当前步骤字段
ALTER TABLE tasks ADD COLUMN current_step VARCHAR(500) COMMENT '当前执行步骤描述';

-- 添加实时日志字段
ALTER TABLE tasks ADD COLUMN realtime_log LONGTEXT COMMENT '实时日志内容';

-- 创建索引以提高查询性能
CREATE INDEX idx_tasks_progress ON tasks(progress_percentage);

-- 如果表已存在且需要重新创建，可以使用以下完整建表语句
/*
DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
    task_id VARCHAR(50) PRIMARY KEY COMMENT '任务ID',
    topic VARCHAR(1000) NOT NULL COMMENT '任务主题',
    status ENUM('PENDING', 'RUNNING', 'COMPLETED', 'FAILED') NOT NULL DEFAULT 'PENDING' COMMENT '任务状态',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    output_file VARCHAR(200) COMMENT '输出文件名',
    output_path VARCHAR(500) COMMENT '输出文件路径',
    log_file VARCHAR(500) COMMENT '日志文件路径',
    error TEXT COMMENT '错误信息',
    stdout TEXT COMMENT '标准输出',
    stderr TEXT COMMENT '标准错误输出',
    results LONGTEXT COMMENT '结果JSON数据',
    progress_percentage INT NOT NULL DEFAULT 0 COMMENT '任务进度百分比(0-100)',
    current_step VARCHAR(500) COMMENT '当前执行步骤描述',
    realtime_log LONGTEXT COMMENT '实时日志内容'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务表';

-- 创建索引
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
CREATE INDEX idx_tasks_updated_at ON tasks(updated_at);
CREATE INDEX idx_tasks_progress ON tasks(progress_percentage);
*/