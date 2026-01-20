name: Terraform Plan

on:
  pull_request:
    branches:
      - main

jobs:
  terraform-plan:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        working-directory: terraform_1
        run: terraform init

      - name: Terraform Validate
        working-directory: terraform_1
        run: terraform validate

      - name: Terraform Plan
        working-directory: terraform_1
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ${{ secrets.AWS_REGION }}
        run: terraform plan
