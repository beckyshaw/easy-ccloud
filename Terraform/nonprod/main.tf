terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-1"
}
resource "aws_s3_bucket" "confluent-schema-backup-dev" {
    bucket = "confluent-schema-backup-dev"
    acl = "private"
    tags = {
        Owner = "Melanie Balmer"
        Email = "Melanie.Balmer@sainsburys.co.uk"
        Costcentre = "PD7391"
        Project = "Food Commercial - Kafka"
        Technical-contact = "support.corekafka@sainsburys.co.uk"
        Region = "eu-west-1"
        Name = "Confluent-Schema-Backup"
        Team = "Support Core Kafka"
        Environment = "dev"
    }
}
resource "aws_s3_bucket" "confluent-schema-backup-nonprod" {
    bucket = "confluent-schema-backup-nonprod"
    acl = "private"
    tags = {
        Owner = "Melanie Balmer"
        Email = "Melanie.Balmer@sainsburys.co.uk"
        Costcentre = "PD7391"
        Project = "Food Commercial - Kafka"
        Technical-contact = "support.corekafka@sainsburys.co.uk"
        Region = "eu-west-1"
        Name = "Confluent-Schema-Backup"
        Team = "Support Core Kafka"
        Environment = "stg"
    }
}
