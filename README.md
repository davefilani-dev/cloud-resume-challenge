# Cloud Resume Challenge (AWS CLI Implementation)

## Overview

This project is my implementation of the Cloud Resume Challenge using AWS core cloud and serverless services. The entire infrastructure setup, deployment, and troubleshooting process was performed primarily through the AWS CLI.

The project demonstrates how modern cloud-native applications can be built using a fully serverless architecture while integrating frontend hosting, CDN delivery, API management, serverless compute, and persistent storage.

---

## Live Demo

* Website: `https://d143b2vwx2w3e2.cloudfront.net`
* API Endpoint: `https://tfp8whs54b.execute-api.us-east-1.amazonaws.com/prod/visitor`  

---

## Architecture

```text
User Browser
      ↓
CloudFront (CDN)
      ↓
S3 Static Website Hosting
      ↓
API Gateway (HTTP API)
      ↓
AWS Lambda
      ↓
DynamoDB
```

---

## AWS Services Used

| Service           | Purpose                            |
| ----------------- | ---------------------------------- |
| Amazon S3         | Static website hosting             |
| Amazon CloudFront | CDN and HTTPS delivery             |
| API Gateway       | HTTP API routing                   |
| AWS Lambda        | Serverless backend logic           |
| DynamoDB          | Persistent visitor counter storage |
| IAM               | Permissions and role management    |

---

## Features

* Static resume website hosted on Amazon S3
* Global content delivery using CloudFront
* Dynamic visitor counter using Lambda + DynamoDB
* API Gateway integration for frontend/backend communication
* CLI-driven deployment workflow
* Cache invalidation/versioning strategy for frontend updates

---

## Project Structure

```text
cloud-resume-challenge/
│
├── index.html
├── script.js
├── error.html
├── lambda_function.py
├── policy.json
├── cf-config.json
├── README.md
└── .gitignore
```

---

## Deployment Workflow

### Frontend Deployment

```bash
aws s3 cp index.html s3://dave-cloud-demo
aws s3 cp script.js s3://dave-cloud-demo
```

### Cache Refresh

```bash
aws cloudfront create-invalidation \
  --distribution-id E3FDSVAGXIYBCH \
  --paths "/*"
```

### Lambda Packaging

```bash
zip function.zip lambda_function.py
```

---

## Key Engineering Concepts Demonstrated

* Serverless architecture
* CDN caching behavior
* IAM permission management
* API routing and integration
* DynamoDB atomic updates
* Static website hosting
* CLI-based cloud operations

---

## Challenges Encountered

### IAM Permission Conflicts

Encountered explicit deny policy issues while configuring AWS permissions and resolved them through root account recovery and IAM policy correction.

### API Gateway Route Misconfiguration

Resolved routing failures caused by missing API integration bindings between API Gateway and Lambda.

### CloudFront Caching Issues

After updating frontend files in the S3 bucket, CloudFront continued serving stale cached versions of the website. Resolved the issue by performing CloudFront cache invalidation to force retrieval of the latest frontend assets from the origin bucket.

### S3 Static Website Errors

Encountered static website hosting errors caused by missing object keys and incomplete website configuration settings. Resolved the issue by correctly configuring the S3 website endpoint and uploading the required frontend files (`index.html` and `error.html`).

---

## Lessons Learned

This project provided hands-on experience with integrating multiple AWS services into a functioning serverless architecture. It also strengthened my understanding of cloud troubleshooting, IAM permissions, deployment workflows, and distributed system behavior.

---

## Author

GitHub: `https://github.com/davefilani-dev`



