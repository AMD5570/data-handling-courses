// ==========================================
// STEP 1: CREATE CONSTRAINTS (Uniqueness)
// ==========================================
CREATE CONSTRAINT course_code IF NOT EXISTS FOR (c:Course) REQUIRE c.code IS UNIQUE;
CREATE CONSTRAINT topic_name IF NOT EXISTS FOR (tp:Topic) REQUIRE tp.name IS UNIQUE;
CREATE CONSTRAINT tool_name IF NOT EXISTS FOR (tl:Tool) REQUIRE tl.name IS UNIQUE;

// ==========================================
// STEP 2: MERGE ALL COURSES
// ==========================================
MERGE (iste230:Course {code: 'ISTE-230', name: 'Intro to Database and Data Modeling'})
MERGE (iste240:Course {code: 'ISTE-240', name: 'Web and Mobile II'})
MERGE (iste330:Course {code: 'ISTE-330', name: 'Database Connectivity and Access'})
MERGE (iste341:Course {code: 'ISTE-341', name: 'Server Programming'})
MERGE (iste430:Course {code: 'ISTE-430', name: 'Information Requirements Modeling'})
MERGE (iste432:Course {code: 'ISTE-432', name: 'Database Application Development'})
MERGE (iste436:Course {code: 'ISTE-436', name: 'Database Management and Access'})
MERGE (iste438:Course {code: 'ISTE-438', name: 'Contemporary Databases'})
MERGE (iste442:Course {code: 'ISTE-442', name: 'Secure Web Application Development'})
MERGE (iste470:Course {code: 'ISTE-470', name: 'Data Mining and Exploration'})
MERGE (iste472:Course {code: 'ISTE-472', name: 'Text Analytics'})
MERGE (iste476:Course {code: 'ISTE-476', name: 'Visual Analytics'})
MERGE (iste500:Course {code: 'ISTE-500', name: 'Senior Development Project I'})
MERGE (iste501:Course {code: 'ISTE-501', name: 'Senior Development Project II'})
MERGE (iste534:Course {code: 'ISTE-534', name: 'Data Warehousing'});

// ==========================================
// STEP 3: ISTE-230 TOOLS & TOPICS
// ==========================================
// Tools
MERGE (tl_mysql:Tool {name: 'MySQL'})
MERGE (tl_mysql_cli:Tool {name: 'MySQL Command Line'})
MERGE (tl_workbench:Tool {name: 'MySQL Workbench'})

// Topics
MERGE (tp_data_org:Topic {name: 'Data Organization'})
MERGE (tp_schemas:Topic {name: 'Schemas'})
MERGE (tp_norm:Topic {name: 'Normalization (1st NF - BCNF)'})
MERGE (tp_er:Topic {name: 'ER Diagrams'})
MERGE (tp_rel:Topic {name: 'Relationships'})
MERGE (tp_ddl:Topic {name: 'DDL Statements'})
MERGE (tp_crud:Topic {name: 'Simple CRUD Operations'})

// Relationships
MERGE (iste230)-[:USES_TOOL]->(tl_mysql)
MERGE (iste230)-[:USES_TOOL]->(tl_mysql_cli)
MERGE (iste230)-[:USES_TOOL]->(tl_workbench)

MERGE (iste230)-[:TEACHES]->(tp_data_org)
MERGE (iste230)-[:TEACHES]->(tp_schemas)
MERGE (iste230)-[:TEACHES]->(tp_norm)
MERGE (iste230)-[:TEACHES]->(tp_er)
MERGE (iste230)-[:TEACHES]->(tp_rel)
MERGE (iste230)-[:TEACHES]->(tp_ddl)
MERGE (iste230)-[:TEACHES]->(tp_crud);

// ==========================================
// STEP 4: ISTE-240 TOOLS & TOPICS
// ==========================================
MERGE (tl_html:Tool {name: 'HTML'})
MERGE (tl_css:Tool {name: 'CSS'})
MERGE (tl_js:Tool {name: 'JavaScript'})
MERGE (tl_php:Tool {name: 'PHP'})
MERGE (tl_adminer:Tool {name: 'Adminer'})
MERGE (tl_ftp:Tool {name: 'FTP'})
MERGE (tl_vscode:Tool {name: 'VS Code'})

MERGE (tp_dyn_creation:Topic {name: 'Dynamic Creation from a Database'})
MERGE (tp_prep_php:Topic {name: 'Prepared Statements in PHP'})
MERGE (tp_crud_php:Topic {name: 'CRUD Operations in PHP'})
MERGE (tp_mysqli:Topic {name: 'DB Connectivity via PHP (mysqli)'})
MERGE (tp_responsive:Topic {name: 'Responsiveness'})

MERGE (iste240)-[:USES_TOOL]->(tl_html)
MERGE (iste240)-[:USES_TOOL]->(tl_css)
MERGE (iste240)-[:USES_TOOL]->(tl_js)
MERGE (iste240)-[:USES_TOOL]->(tl_php)
MERGE (iste240)-[:USES_TOOL]->(tl_mysql)
MERGE (iste240)-[:USES_TOOL]->(tl_adminer)
MERGE (iste240)-[:USES_TOOL]->(tl_ftp)
MERGE (iste240)-[:USES_TOOL]->(tl_vscode)

MERGE (iste240)-[:TEACHES]->(tp_dyn_creation)
MERGE (iste240)-[:TEACHES]->(tp_prep_php)
MERGE (iste240)-[:TEACHES]->(tp_crud_php)
MERGE (iste240)-[:TEACHES]->(tp_mysqli)
MERGE (iste240)-[:TEACHES]->(tp_responsive);

// ==========================================
// STEP 5: ISTE-330 TOOLS & TOPICS
// ==========================================
MERGE (tl_java:Tool {name: 'Java'})
MERGE (tl_db_drivers:Tool {name: 'DB Drivers'})

MERGE (tp_prep_java:Topic {name: 'Prepared Statements in Java'})
MERGE (tp_drivers:Topic {name: 'Database Drivers'})
MERGE (tp_trans:Topic {name: 'Transactions'})
MERGE (tp_stored_proc:Topic {name: 'Stored Procedures'})
MERGE (tp_crud_java:Topic {name: 'CRUD Operations via Java'})
MERGE (tp_pres_data_layer:Topic {name: 'Presentation + Data Layer Creation'})

MERGE (iste330)-[:USES_TOOL]->(tl_java)
MERGE (iste330)-[:USES_TOOL]->(tl_db_drivers)
MERGE (iste330)-[:USES_TOOL]->(tl_mysql)
MERGE (iste330)-[:USES_TOOL]->(tl_mysql_cli)
MERGE (iste330)-[:USES_TOOL]->(tl_workbench)

MERGE (iste330)-[:TEACHES]->(tp_prep_java)
MERGE (iste330)-[:TEACHES]->(tp_drivers)
MERGE (iste330)-[:TEACHES]->(tp_trans)
MERGE (iste330)-[:TEACHES]->(tp_stored_proc)
MERGE (iste330)-[:TEACHES]->(tp_crud_java)
MERGE (iste330)-[:TEACHES]->(tp_pres_data_layer);

// ==========================================
// STEP 6: ISTE-341 TOOLS & TOPICS
// ==========================================
MERGE (tl_csharp:Tool {name: 'C#'})
MERGE (tl_nodejs:Tool {name: 'Node.js'})
MERGE (tl_mongodb:Tool {name: 'MongoDB'})
MERGE (tl_postman:Tool {name: 'Postman'})
MERGE (tl_soapui:Tool {name: 'SoapUI'})
MERGE (tl_swagger:Tool {name: 'SwaggerUI'})
MERGE (tl_docker:Tool {name: 'Docker'})

MERGE (tp_db_access:Topic {name: 'Database Access + Manipulation'})
MERGE (tp_crud_multi:Topic {name: 'CRUD Operations via PHP, Java, C#, and Node'})
MERGE (tp_app_sec:Topic {name: 'Application Security'})
MERGE (tp_libs:Topic {name: 'Libraries'})
MERGE (tp_scripting:Topic {name: 'Scripting'})
MERGE (tp_rest:Topic {name: 'REST'})
MERGE (tp_soap:Topic {name: 'SOAP'})
MERGE (tp_proxies:Topic {name: 'Proxies'})
MERGE (tp_microservices:Topic {name: 'Microservices'})

MERGE (iste341)-[:USES_TOOL]->(tl_php)
MERGE (iste341)-[:USES_TOOL]->(tl_java)
MERGE (iste341)-[:USES_TOOL]->(tl_csharp)
MERGE (iste341)-[:USES_TOOL]->(tl_nodejs)
MERGE (iste341)-[:USES_TOOL]->(tl_mysql)
MERGE (iste341)-[:USES_TOOL]->(tl_mongodb)
MERGE (iste341)-[:USES_TOOL]->(tl_postman)
MERGE (iste341)-[:USES_TOOL]->(tl_soapui)
MERGE (iste341)-[:USES_TOOL]->(tl_swagger)
MERGE (iste341)-[:USES_TOOL]->(tl_mysql_cli)
MERGE (iste341)-[:USES_TOOL]->(tl_docker)
MERGE (iste341)-[:USES_TOOL]->(tl_ftp)
MERGE (iste341)-[:USES_TOOL]->(tl_vscode)

MERGE (iste341)-[:TEACHES]->(tp_db_access)
MERGE (iste341)-[:TEACHES]->(tp_crud_multi)
MERGE (iste341)-[:TEACHES]->(tp_app_sec)
MERGE (iste341)-[:TEACHES]->(tp_libs)
MERGE (iste341)-[:TEACHES]->(tp_scripting)
MERGE (iste341)-[:TEACHES]->(tp_rest)
MERGE (iste341)-[:TEACHES]->(tp_soap)
MERGE (iste341)-[:TEACHES]->(tp_proxies)
MERGE (iste341)-[:TEACHES]->(tp_microservices);

// ==========================================
// STEP 7: ISTE-430 TOPICS
// ==========================================
MERGE (tp_semiotics:Topic {name: 'Semiotics'})
MERGE (tp_interaction:Topic {name: 'Interaction Methods'})
MERGE (tp_req_psych:Topic {name: 'Psychology and Requirements Elicitation'})
MERGE (tp_lifecycle:Topic {name: 'Lifecycle Models'})
MERGE (tp_pm:Topic {name: 'Project Management'})
MERGE (tp_req_gath:Topic {name: 'Requirements Gathering'})
MERGE (tp_contextual:Topic {name: 'Contextual Abstraction'})
MERGE (tp_metadata:Topic {name: 'Metadata Development'})
MERGE (tp_data_analysis:Topic {name: 'Data Analysis'})
MERGE (tp_modeling_spec:Topic {name: 'Modeling and Specification'})
MERGE (tp_process_analysis:Topic {name: 'Process Analysis'})
MERGE (tp_state_analysis:Topic {name: 'State Analysis'})
MERGE (tp_model_rel:Topic {name: 'Model Relationships'})

MERGE (iste430)-[:TEACHES]->(tp_semiotics)
MERGE (iste430)-[:TEACHES]->(tp_interaction)
MERGE (iste430)-[:TEACHES]->(tp_req_psych)
MERGE (iste430)-[:TEACHES]->(tp_lifecycle)
MERGE (iste430)-[:TEACHES]->(tp_pm)
MERGE (iste430)-[:TEACHES]->(tp_req_gath)
MERGE (iste430)-[:TEACHES]->(tp_contextual)
MERGE (iste430)-[:TEACHES]->(tp_metadata)
MERGE (iste430)-[:TEACHES]->(tp_data_analysis)
MERGE (iste430)-[:TEACHES]->(tp_modeling_spec)
MERGE (iste430)-[:TEACHES]->(tp_process_analysis)
MERGE (iste430)-[:TEACHES]->(tp_state_analysis)
MERGE (iste430)-[:TEACHES]->(tp_model_rel);

// ==========================================
// STEP 8: ISTE-432 TOOLS & TOPICS
// ==========================================
MERGE (tl_postgres:Tool {name: 'Postgres'})
MERGE (tl_pgadmin:Tool {name: 'pgAdmin'})
MERGE (tl_datagrip:Tool {name: 'DataGrip'})
MERGE (tl_jupyter:Tool {name: 'Jupyter notebooks'})
MERGE (tl_linux:Tool {name: 'Linux'})

MERGE (tp_db_design:Topic {name: 'Database Design'})
MERGE (tp_server_arch:Topic {name: 'Server Architecture'})
MERGE (tp_infra:Topic {name: 'Infrastructure'})
MERGE (tp_testing:Topic {name: 'Testing'})
MERGE (tp_auth:Topic {name: 'Authentication & Authorization'})
MERGE (tp_etl:Topic {name: 'ETL'})
MERGE (tp_multiuser:Topic {name: 'Multi-User Issues'})
MERGE (tp_trans_locking:Topic {name: 'Transactions & Locking'})
MERGE (tp_data_integrity:Topic {name: 'Data Integrity'})
MERGE (tp_extensibility:Topic {name: 'Extensibility'})
MERGE (tp_performance:Topic {name: 'Performance'})
MERGE (tp_data_eng:Topic {name: 'Data Engineering'})
MERGE (tp_packaging:Topic {name: 'Packaging'})
MERGE (tp_deployment:Topic {name: 'Deployment'})
MERGE (tp_db_app_dev:Topic {name: 'Database Application Development'})

MERGE (iste432)-[:USES_TOOL]->(tl_postgres)
MERGE (iste432)-[:USES_TOOL]->(tl_pgadmin)
MERGE (iste432)-[:USES_TOOL]->(tl_nodejs)
MERGE (iste432)-[:USES_TOOL]->(tl_vscode)
MERGE (iste432)-[:USES_TOOL]->(tl_postman)
MERGE (iste432)-[:USES_TOOL]->(tl_datagrip)
MERGE (iste432)-[:USES_TOOL]->(tl_jupyter)
MERGE (iste432)-[:USES_TOOL]->(tl_linux)

MERGE (iste432)-[:TEACHES]->(tp_db_design)
MERGE (iste432)-[:TEACHES]->(tp_server_arch)
MERGE (iste432)-[:TEACHES]->(tp_infra)
MERGE (iste432)-[:TEACHES]->(tp_testing)
MERGE (iste432)-[:TEACHES]->(tp_auth)
MERGE (iste432)-[:TEACHES]->(tp_etl)
MERGE (iste432)-[:TEACHES]->(tp_multiuser)
MERGE (iste432)-[:TEACHES]->(tp_trans_locking)
MERGE (iste432)-[:TEACHES]->(tp_data_integrity)
MERGE (iste432)-[:TEACHES]->(tp_extensibility)
MERGE (iste432)-[:TEACHES]->(tp_performance)
MERGE (iste432)-[:TEACHES]->(tp_data_eng)
MERGE (iste432)-[:TEACHES]->(tp_packaging)
MERGE (iste432)-[:TEACHES]->(tp_deployment)
MERGE (iste432)-[:TEACHES]->(tp_db_app_dev);

// ==========================================
// STEP 9: ISTE-436 TOOLS & TOPICS
// ==========================================
MERGE (tl_aws_ec2:Tool {name: 'AWS EC2'})
MERGE (tl_aws_s3:Tool {name: 'AWS S3'})
MERGE (tl_oracle:Tool {name: 'Oracle Database'})

MERGE (tp_logical_layout:Topic {name: 'Database Logical Layout'})
MERGE (tp_phys_arch:Topic {name: 'Database Physical Architecture'})
MERGE (tp_db_netting:Topic {name: 'Database Networking'})
MERGE (tp_access_ctrl:Topic {name: 'Access Controls'})
MERGE (tp_db_trans:Topic {name: 'Database Transactions'})
MERGE (tp_backup_rec:Topic {name: 'Backup & Recovery'})
MERGE (tp_oracle_ai:Topic {name: 'Oracle AI Database'})

MERGE (iste436)-[:USES_TOOL]->(tl_aws_ec2)
MERGE (iste436)-[:USES_TOOL]->(tl_aws_s3)
MERGE (iste436)-[:USES_TOOL]->(tl_oracle)
MERGE (iste436)-[:USES_TOOL]->(tl_linux)

MERGE (iste436)-[:TEACHES]->(tp_logical_layout)
MERGE (iste436)-[:TEACHES]->(tp_phys_arch)
MERGE (iste436)-[:TEACHES]->(tp_db_netting)
MERGE (iste436)-[:TEACHES]->(tp_access_ctrl)
MERGE (iste436)-[:TEACHES]->(tp_db_trans)
MERGE (iste436)-[:TEACHES]->(tp_backup_rec)
MERGE (iste436)-[:TEACHES]->(tp_oracle_ai);

// ==========================================
// STEP 10: ISTE-438 TOOLS & TOPICS
// ==========================================
MERGE (tl_xml:Tool {name: 'XML'})
MERGE (tl_mongo_compass:Tool {name: 'MongoDB Compass'})
MERGE (tl_neo4j:Tool {name: 'Neo4j'})
MERGE (tl_neo4j_desk:Tool {name: 'Neo4j Desktop'})
MERGE (tl_redis:Tool {name: 'Redis'})
MERGE (tl_cassandra:Tool {name: 'Cassandra'})

MERGE (tp_doc_db:Topic {name: 'Document Databases'})
MERGE (tp_graph_db:Topic {name: 'Graph Databases'})
MERGE (tp_kv_db:Topic {name: 'Key-Value Databases'})
MERGE (tp_wide_col:Topic {name: 'Wide-Column Databases'})
MERGE (tp_vec_db:Topic {name: 'Vector Databases'})
MERGE (tp_replication:Topic {name: 'Replication'})
MERGE (tp_sharding:Topic {name: 'Sharding & Partitioning'})
MERGE (tp_nonrel_model:Topic {name: 'Non-relational Database Modeling'})
MERGE (tp_docs_rel:Topic {name: 'Documents in relational databases'})

MERGE (iste438)-[:USES_TOOL]->(tl_xml)
MERGE (iste438)-[:USES_TOOL]->(tl_mongodb)
MERGE (iste438)-[:USES_TOOL]->(tl_mongo_compass)
MERGE (iste438)-[:USES_TOOL]->(tl_neo4j)
MERGE (iste438)-[:USES_TOOL]->(tl_neo4j_desk)
MERGE (iste438)-[:USES_TOOL]->(tl_redis)
MERGE (iste438)-[:USES_TOOL]->(tl_cassandra)
MERGE (iste438)-[:USES_TOOL]->(tl_vscode)
MERGE (iste438)-[:USES_TOOL]->(tl_datagrip)

MERGE (iste438)-[:TEACHES]->(tp_doc_db)
MERGE (iste438)-[:TEACHES]->(tp_graph_db)
MERGE (iste438)-[:TEACHES]->(tp_kv_db)
MERGE (iste438)-[:TEACHES]->(tp_wide_col)
MERGE (iste438)-[:TEACHES]->(tp_vec_db)
MERGE (iste438)-[:TEACHES]->(tp_replication)
MERGE (iste438)-[:TEACHES]->(tp_sharding)
MERGE (iste438)-[:TEACHES]->(tp_nonrel_model)
MERGE (iste438)-[:TEACHES]->(tp_docs_rel)
MERGE (iste438)-[:TEACHES]->(tp_db_app_dev);

// ==========================================
// STEP 11: ISTE-442 TOOLS & TOPICS
// ==========================================
MERGE (tl_go:Tool {name: 'Go'})
MERGE (tl_svg:Tool {name: 'SVG'})
MERGE (tl_wasm:Tool {name: 'WebAssembly'})
MERGE (tl_fiddler:Tool {name: 'Fiddler HTTP Proxy'})
MERGE (tl_charles:Tool {name: 'Charles HTTP Proxy'})
MERGE (tl_zap:Tool {name: 'OWASP ZAP'})

MERGE (tp_web_sec:Topic {name: 'Web application security'})
MERGE (tp_xss:Topic {name: 'Cross-site scripting (XSS)'})
MERGE (tp_csrf:Topic {name: 'Cross-site request forgery (CSRF)'})
MERGE (tp_sqli:Topic {name: 'SQL injections'})
MERGE (tp_buffer:Topic {name: 'Buffer overflow'})
MERGE (tp_sess_sec:Topic {name: 'Session security'})
MERGE (tp_sec_http:Topic {name: 'Secure HTTP'})
MERGE (tp_http2:Topic {name: 'HTTP/2'})
MERGE (tp_ddos:Topic {name: 'DDOS attacks'})
MERGE (tp_sec_dev_wf:Topic {name: 'Secure development workflow'})
MERGE (tp_proto_inh:Topic {name: 'Prototypal inheritance'})
MERGE (tp_srv_arch:Topic {name: 'Server-side architecture'})

MERGE (iste442)-[:USES_TOOL]->(tl_php)
MERGE (iste442)-[:USES_TOOL]->(tl_nodejs)
MERGE (iste442)-[:USES_TOOL]->(tl_js)
MERGE (iste442)-[:USES_TOOL]->(tl_go)
MERGE (iste442)-[:USES_TOOL]->(tl_svg)
MERGE (iste442)-[:USES_TOOL]->(tl_wasm)
MERGE (iste442)-[:USES_TOOL]->(tl_postman)
MERGE (iste442)-[:USES_TOOL]->(tl_fiddler)
MERGE (iste442)-[:USES_TOOL]->(tl_charles)
MERGE (iste442)-[:USES_TOOL]->(tl_zap)
MERGE (iste442)-[:USES_TOOL]->(tl_vscode)

MERGE (iste442)-[:TEACHES]->(tp_web_sec)
MERGE (iste442)-[:TEACHES]->(tp_xss)
MERGE (iste442)-[:TEACHES]->(tp_csrf)
MERGE (iste442)-[:TEACHES]->(tp_sqli)
MERGE (iste442)-[:TEACHES]->(tp_buffer)
MERGE (iste442)-[:TEACHES]->(tp_sess_sec)
MERGE (iste442)-[:TEACHES]->(tp_sec_http)
MERGE (iste442)-[:TEACHES]->(tp_http2)
MERGE (iste442)-[:TEACHES]->(tp_ddos)
MERGE (iste442)-[:TEACHES]->(tp_sec_dev_wf)
MERGE (iste442)-[:TEACHES]->(tp_proto_inh)
MERGE (iste442)-[:TEACHES]->(tp_srv_arch);

// ==========================================
// STEP 12: ISTE-470 TOOLS & TOPICS
// ==========================================
MERGE (tl_weka:Tool {name: 'Weka'})
MERGE (tl_python:Tool {name: 'Python'})

MERGE (tp_data_mining:Topic {name: 'Data mining'})
MERGE (tp_ai:Topic {name: 'AI'})
MERGE (tp_exploration:Topic {name: 'Data exploration'})
MERGE (tp_preproc:Topic {name: 'Preprocessing'})
MERGE (tp_viz:Topic {name: 'Data visualization'})
MERGE (tp_class:Topic {name: 'Classification'})
MERGE (tp_overfitting:Topic {name: 'Overfitting'})
MERGE (tp_accuracy:Topic {name: 'Accuracy calculation'})
MERGE (tp_precision:Topic {name: 'Precision'})
MERGE (tp_recall:Topic {name: 'Recall'})
MERGE (tp_dt:Topic {name: 'Decision trees'})
MERGE (tp_knn:Topic {name: 'Nearest neighbor'})
MERGE (tp_ann:Topic {name: 'Artificial neural networks'})
MERGE (tp_svm:Topic {name: 'Support vector machines'})
MERGE (tp_clustering:Topic {name: 'Clustering'})
MERGE (tp_kmeans:Topic {name: 'K-means'})
MERGE (tp_assoc:Topic {name: 'Association rule mining'})

MERGE (iste470)-[:USES_TOOL]->(tl_weka)
MERGE (iste470)-[:USES_TOOL]->(tl_jupyter)
MERGE (iste470)-[:USES_TOOL]->(tl_python)

MERGE (iste470)-[:TEACHES]->(tp_data_mining)
MERGE (iste470)-[:TEACHES]->(tp_ai)
MERGE (iste470)-[:TEACHES]->(tp_exploration)
MERGE (iste470)-[:TEACHES]->(tp_preproc)
MERGE (iste470)-[:TEACHES]->(tp_viz)
MERGE (iste470)-[:TEACHES]->(tp_class)
MERGE (iste470)-[:TEACHES]->(tp_overfitting)
MERGE (iste470)-[:TEACHES]->(tp_accuracy)
MERGE (iste470)-[:TEACHES]->(tp_precision)
MERGE (iste470)-[:TEACHES]->(tp_recall)
MERGE (iste470)-[:TEACHES]->(tp_dt)
MERGE (iste470)-[:TEACHES]->(tp_knn)
MERGE (iste470)-[:TEACHES]->(tp_ann)
MERGE (iste470)-[:TEACHES]->(tp_svm)
MERGE (iste470)-[:TEACHES]->(tp_clustering)
MERGE (iste470)-[:TEACHES]->(tp_kmeans)
MERGE (iste470)-[:TEACHES]->(tp_assoc);

// ==========================================
// STEP 13: ISTE-472 TOPICS
// ==========================================
MERGE (tp_encoding:Topic {name: 'Encoding'})
MERGE (tp_indexing:Topic {name: 'Indexing'})
MERGE (tp_storing:Topic {name: 'Storing'})
MERGE (tp_searching:Topic {name: 'Searching'})
MERGE (tp_processing:Topic {name: 'Processing'})
MERGE (tp_presenting:Topic {name: 'Presenting textual information'})
MERGE (tp_categorization:Topic {name: 'Categorization'})
MERGE (tp_link_analysis:Topic {name: 'Link analysis'})

MERGE (iste472)-[:TEACHES]->(tp_encoding)
MERGE (iste472)-[:TEACHES]->(tp_indexing)
MERGE (iste472)-[:TEACHES]->(tp_preproc)
MERGE (iste472)-[:TEACHES]->(tp_storing)
MERGE (iste472)-[:TEACHES]->(tp_searching)
MERGE (iste472)-[:TEACHES]->(tp_processing)
MERGE (iste472)-[:TEACHES]->(tp_presenting)
MERGE (iste472)-[:TEACHES]->(tp_categorization)
MERGE (iste472)-[:TEACHES]->(tp_clustering)
MERGE (iste472)-[:TEACHES]->(tp_link_analysis);

// ==========================================
// STEP 14: ISTE-476 TOOLS & TOPICS
// ==========================================
MERGE (tl_viz_tech:Tool {name: 'Visualization technologies'})

MERGE (tp_analytical:Topic {name: 'Analytical reasoning'})
MERGE (tp_situation:Topic {name: 'Situation awareness'})
MERGE (tp_visual_rep:Topic {name: 'Visual representation and interaction'})
MERGE (tp_cognitive:Topic {name: 'Cognitive and perceptual principles'})
MERGE (tp_large_datasets:Topic {name: 'Large-scale data set analysis'})
MERGE (tp_uncertainty:Topic {name: 'Uncertainty'})
MERGE (tp_data_quality:Topic {name: 'Data quality'})
MERGE (tp_storytelling:Topic {name: 'Visual story telling'})
MERGE (tp_res_trends:Topic {name: 'Research trends'})

MERGE (iste476)-[:USES_TOOL]->(tl_viz_tech)

MERGE (iste476)-[:TEACHES]->(tp_analytical)
MERGE (iste476)-[:TEACHES]->(tp_situation)
MERGE (iste476)-[:TEACHES]->(tp_visual_rep)
MERGE (iste476)-[:TEACHES]->(tp_cognitive)
MERGE (iste476)-[:TEACHES]->(tp_large_datasets)
MERGE (iste476)-[:TEACHES]->(tp_accuracy)
MERGE (iste476)-[:TEACHES]->(tp_uncertainty)
MERGE (iste476)-[:TEACHES]->(tp_data_quality)
MERGE (iste476)-[:TEACHES]->(tp_storytelling)
MERGE (iste476)-[:TEACHES]->(tp_res_trends);

// ==========================================
// STEP 15: ISTE-500 TOOLS & TOPICS
// ==========================================
MERGE (tl_gantt:Tool {name: 'Gantt charts'})
MERGE (tl_workflow_diag:Tool {name: 'Workflow diagrams'})
MERGE (tl_dfd:Tool {name: 'Data flow diagrams'})

MERGE (tp_ethics:Topic {name: 'Ethics'})
MERGE (tp_cost_est:Topic {name: 'Cost estimation'})
MERGE (tp_mockups:Topic {name: 'Use case and mockup development'})
MERGE (tp_dev_meth:Topic {name: 'Development methodologies'})
MERGE (tp_feasibility:Topic {name: 'Feasibility & risk management'})
MERGE (tp_change_mgmt:Topic {name: 'Change management'})
MERGE (tp_tech_verif:Topic {name: 'Technology verification'})

MERGE (iste500)-[:USES_TOOL]->(tl_gantt)
MERGE (iste500)-[:USES_TOOL]->(tl_workflow_diag)
MERGE (iste500)-[:USES_TOOL]->(tl_dfd)

MERGE (iste500)-[:TEACHES]->(tp_ethics)
MERGE (iste500)-[:TEACHES]->(tp_req_gath)
MERGE (iste500)-[:TEACHES]->(tp_cost_est)
MERGE (iste500)-[:TEACHES]->(tp_mockups)
MERGE (iste500)-[:TEACHES]->(tp_dev_meth)
MERGE (iste500)-[:TEACHES]->(tp_pm)
MERGE (iste500)-[:TEACHES]->(tp_feasibility)
MERGE (iste500)-[:TEACHES]->(tp_change_mgmt)
MERGE (iste500)-[:TEACHES]->(tp_tech_verif);

// ==========================================
// STEP 16: ISTE-501 TOPICS
// ==========================================
MERGE (tp_doc_considerations:Topic {name: 'Documentation considerations'})
MERGE (tp_change_strat:Topic {name: 'Change strategy'})
MERGE (tp_sec_conseq:Topic {name: 'Secondary consequences'})

MERGE (iste501)-[:TEACHES]->(tp_doc_considerations)
MERGE (iste501)-[:TEACHES]->(tp_deployment)
MERGE (iste501)-[:TEACHES]->(tp_change_strat)
MERGE (iste501)-[:TEACHES]->(tp_sec_conseq);

// ==========================================
// STEP 17: ISTE-534 TOOLS & TOPICS
// ==========================================
MERGE (tl_pentaho:Tool {name: 'Pentaho Data Integration'})
MERGE (tl_sas:Tool {name: 'SAS'})
MERGE (tl_airflow:Tool {name: 'Apache Airflow'})
MERGE (tl_tableau:Tool {name: 'Tableau'})

MERGE (tp_dim_modeling:Topic {name: 'Dimensional modeling'})
MERGE (tp_dim_analysis:Topic {name: 'Dimensional analysis'})

MERGE (iste534)-[:USES_TOOL]->(tl_mysql)
MERGE (iste534)-[:USES_TOOL]->(tl_vscode)
MERGE (iste534)-[:USES_TOOL]->(tl_datagrip)
MERGE (iste534)-[:USES_TOOL]->(tl_pentaho)
MERGE (iste534)-[:USES_TOOL]->(tl_sas)
MERGE (iste534)-[:USES_TOOL]->(tl_airflow)
MERGE (iste534)-[:USES_TOOL]->(tl_tableau)

MERGE (iste534)-[:TEACHES]->(tp_dim_modeling)
MERGE (iste534)-[:TEACHES]->(tp_etl)
MERGE (iste534)-[:TEACHES]->(tp_dim_analysis)
MERGE (iste534)-[:TEACHES]->(tp_viz);