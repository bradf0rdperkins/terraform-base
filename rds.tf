resource "aws_db_instance" "fcc-prod-rds-mysql" {
  allocated_storage          = "${var.DB_ALLOCATED_STORAGE}"
  storage_type               = "gp2"
  engine                     = "mysql"
  engine_version             = "5.7"
  instance_class             = "db.t2.micro"
  name                       = "${var.DB_NAME}"
  identifier                 = "${var.DB_NAME}"
  username                   = "${var.DB_USERNAME}"
  password                   = "${var.DB_PASS}"
  parameter_group_name       = "default.mysql5.7"
  db_subnet_group_name       = "${aws_db_subnet_group.fcc-acedirect-db-subnet-group.id}"
  auto_minor_version_upgrade = true
  port                       = "${var.DB_PORT}"
}
