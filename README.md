# LLMxMapReduce Backend Service

这是一个Java Spring Boot后端服务，用于集成LLMxMapReduce_V2系统，提供REST API接口来接收研究题目、执行pipeline并返回生成的报告。

## 功能特性

- 提交研究题目并异步执行LLM MapReduce pipeline
- 实时查询任务执行状态
- 获取和格式化生成的研究报告（支持HTML和Markdown格式）
- 任务管理和历史记录
- 完整的错误处理和日志记录

## 技术栈

- Java 17
- Spring Boot 3.2.0
- Maven
- Jackson (JSON处理)
- SLF4J + Logback (日志)

## 项目结构

```
backend-java/
├── src/main/java/com/llm/mapreduce/
│   ├── LlmMapReduceApplication.java     # 主应用类
│   ├── controller/
│   │   └── TaskController.java          # REST API控制器
│   ├── service/
│   │   ├── TaskManager.java             # 任务管理服务
│   │   ├── PipelineExecutionService.java # Pipeline执行服务
│   │   └── ReportParsingService.java    # 报告解析服务
│   ├── model/
│   │   └── Task.java                    # 任务数据模型
│   └── dto/
│       ├── TaskSubmissionRequest.java   # 任务提交请求DTO
│       └── ApiResponse.java             # API响应DTO
├── src/main/resources/
│   └── application.yml                  # 应用配置
├── pom.xml                              # Maven配置
└── README.md                            # 本文件
```

## API接口

### 1. 健康检查
```
GET /api/health
```

### 2. 提交研究任务
```
POST /api/submit
Content-Type: application/json

{
  "topic": "研究题目"
}
```

### 3. 查询任务状态
```
GET /api/status/{taskId}
```

### 4. 获取任务结果
```
GET /api/result/{taskId}
```

### 5. 获取HTML格式报告
```
GET /api/report/{taskId}/html
```

### 6. 获取Markdown格式报告
```
GET /api/report/{taskId}/markdown
```

### 7. 获取所有任务列表
```
GET /api/tasks
```

## 快速开始

### 环境要求

- Java 17 或更高版本
- Maven 3.6+
- LLMxMapReduce_V2项目已正确配置

### 安装运行

1. 进入backend-java目录：
```bash
cd backend-java
```

2. 编译项目：
```bash
mvn clean compile
```

3. 运行应用：
```bash
mvn spring-boot:run
```

或者打包后运行：
```bash
mvn clean package
java -jar target/llm-mapreduce-backend-1.0.0.jar
```

4. 访问API：
服务启动后，访问 http://localhost:8080/api/health 检查服务状态

### 配置说明

在 `application.yml` 中可以配置：

- `server.port`: 服务端口（默认8080）
- `llm.mapreduce.project.root`: LLMxMapReduce_V2项目根目录路径
- 日志级别和输出配置
- 线程池配置

### 使用示例

1. 提交任务：
```bash
curl -X POST http://localhost:8080/api/submit \
  -H "Content-Type: application/json" \
  -d '{"topic": "AI对未来教育的影响"}'
```

2. 查询状态：
```bash
curl http://localhost:8080/api/status/{taskId}
```

3. 获取结果：
```bash
curl http://localhost:8080/api/result/{taskId}
```

## 开发说明

### 任务生命周期

1. **PENDING**: 任务已创建，等待执行
2. **RUNNING**: 任务正在执行中
3. **COMPLETED**: 任务执行成功
4. **FAILED**: 任务执行失败

### 错误处理

服务包含完整的错误处理机制：
- 输入验证
- 文件系统错误处理
- Pipeline执行错误处理
- JSON解析错误处理

### 日志记录

- 应用日志保存在 `logs/application.log`
- 支持日志轮转和历史保留
- 不同级别的日志输出

## 注意事项

1. 确保LLMxMapReduce_V2项目的pipeline脚本有执行权限
2. 确保必要的环境变量已正确设置（API keys等）
3. 服务使用内存存储任务状态，重启后任务记录会丢失
4. 生产环境建议使用数据库存储任务状态

## 故障排除

1. 检查pipeline脚本是否可执行：
```bash
ls -la ../scripts/pipeline_start.sh
```

2. 检查项目根路径配置是否正确

3. 查看应用日志：
```bash
tail -f logs/application.log
```

4. 检查健康状态：
```bash
curl http://localhost:8080/api/health
```