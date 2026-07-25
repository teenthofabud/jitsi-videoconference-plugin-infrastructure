TODO list for contact form backend with Java Lambda + RDS

1. Create migration Lambda code
   - Plain Java Maven project.
   - No Spring Boot, no Hibernate/JPA.
   - Runs SQL like CREATE TABLE IF NOT EXISTS contact_messages (...).
   - This Lambda is invoked manually/from GitHub Actions after Terraform apply.

2. Create contact form Lambda code
   - Plain Java Maven project.
   - Receives POST /contact request.
   - Validates name/email/message.
   - Inserts contact message into RDS PostgreSQ L using JDBC.
   - Returns success/error response.

3. Update Angular app
   - Add contact form submit logic.
   - Make AJAX/HTTP POST call to backend API.
   - Store backend URL in Angular environment config.
   - Prefer predictable URL like:
     https://api.shahad42069.dpdns.org/contact

4. Terraform: create VPC/networking
   - Create VPC.
   - Create 2 private subnets in 2 different AZs.
   - Create private route table.
   - Create Lambda security group.
   - Create RDS security group.
   - Allow RDS SG inbound PostgreSQL 5432 from Lambda SG.
   - No NAT needed if Lambda only talks to private RDS.

5. Terraform: create RDS PostgreSQL
   - Create DB subnet group using the 2 private subnets.
   - Create private RDS PostgreSQL instance.
   - Configure DB name, username/password, storage, backups.
   - Terraform creates DB instance/database, not tables.

6. Terraform: create migration Lambda
   - Runtime: java21.
   - Handler: MigrationHandler.
   - Attach to same VPC/private subnets.
   - Use Lambda SG.
   - Pass DB env vars/secrets.
   - This Lambda creates/updates tables.

7. Terraform: create contact Lambda
   - Runtime: java21.
   - Handler: ContactHandler.
   - Attach to same VPC/private subnets.
   - Use Lambda SG.
   - Pass DB env vars/secrets.
   - This Lambda handles website form submissions.

8. Terraform: create API Gateway
   - Create HTTP API.
   - Add POST /contact route.
   - Integrate route with contact Lambda.
   - Enable CORS for website domain.

9. Terraform: create API custom domain
   - Create API domain:
     api.shahad42069.dpdns.org
   - Map API Gateway stage/routes to this domain.
   - This gives Angular a stable backend URL.

10. Terraform: create Cloudflare DNS record
   - Create DNS record for:
     api.shahad42069.dpdns.org
   - Point it to API Gateway custom domain target.
   - Keep website and API separate:
     www.shahad42069.dpdns.org -> static website
     api.shahad42069.dpdns.org -> contact API

11. Update main Terraform deploy workflow
   - Checkout repo.
   - Build Java Lambda JARs.
   - Run terraform init/plan/apply.
   - Provision VPC, RDS, Lambdas, API Gateway, Cloudflare DNS.

12. Create separate migration workflow
   - Manual workflow_dispatch.
   - Select environment: dev/qa/prod.
   - Configure AWS credentials.
   - Invoke migration Lambda using aws lambda invoke.
   - This creates/updates DB tables after infra is deployed.

13. Test end-to-end
   - Run Terraform deploy.
   - Run migration workflow.
   - Submit Angular contact form.
   - Confirm API Gateway invokes contact Lambda.
   - Confirm contact Lambda writes row into RDS.
