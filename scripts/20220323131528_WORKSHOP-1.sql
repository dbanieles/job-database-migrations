-- // WORKSHOP-1
-- Migration SQL that makes the change goes here.

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    course VARCHAR NOT NULL 
); 

CREATE TABLE IF NOT EXISTS message_template (
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    description VARCHAR,
    template VARCHAR NOT NULL
    type VARCHAR NOT NULL
); 

CREATE TABLE IF NOT EXISTS message_outbox (
    id SERIAL PRIMARY KEY,
    content VARCHAR NOT NULL,
    sender VARCHAR NOT NULL,
    receiver VARCHAR NOT NULL,
    templateId INTEGER NOT NULL
    date TIMESTAMP NOT NULL 
);


INSERT INTO message_template (id,name,template,type) VALUES (1,'TAG_TEMPLATE','Templete to send message on Teams','{''type'': ''message'',''attachments'': [{''contentType'': ''application/vnd.microsoft.card.adaptive'',''content'': {''type'': ''AdaptiveCard'',''body'': [{''type'': ''TextBlock'',''size'': ''Medium'',''weight'': ''Bolder'',''text'': ''Devops Workshop message''}, {''type'': ''TextBlock'',''text'': ''Hi <at><mentionedname></at>, <messagecontent>''}],''$schema'': ''http://adaptivecards.io/schemas/adaptive-card.json'',''version'': ''1.0'',''msteams'': {''entities'': [{''type'': ''mention'',''text'': ''<at><mentionedname></at>'',''mentioned'': {''id'': ''<mentionedemail>'',''name'': ''<mentionedname>''}},{''type'': ''mention'',''text'': ''<at><mentionedname></at>'',''mentioned'': {''id'': ''87d349ed-44d7-43e1-9a83-5f2406dee5bd'',''name'': ''<mentionedname>''}}]}}}]}','Teams') ON CONFLICT (id) DO NOTHING;
INSERT INTO message_template (id,name,template,type) VALUES (2,'TASK_TEMPLATE','Templete to send Task on Teams','','Teams') ON CONFLICT (id) DO NOTHING;
INSERT INTO message_template (id,name,template,type) VALUES (3,'TASK_TEMPLATE','','','Teams') ON CONFLICT (id) DO NOTHING;
INSERT INTO message_template (id,name,template,type) VALUES (4,'EMAIL_TEMPLATE','Template to send email message','','Email') ON CONFLICT (id) DO NOTHING;

INSERT INTO users (name,email,password,course) VALUES ('Daniele','daniele.baggio@bitsrl.net','test123','DEVOPS');
INSERT INTO users (name,email,password,course) VALUES ('Davide','davide.rossi@bitsrl.net','test123','DEVOPS');
INSERT INTO users (name,email,password,course) VALUES ('Marco','marco.verdi@bitsrl.net','test123','DEVOPS');


-- //@UNDO
-- SQL to undo the change goes here.

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS message_template;
DROP TABLE IF EXISTS message_outbox;
