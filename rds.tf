resource "aws_db_instance" "default" {
  allocated_storage          = "${DB_ALLOCATED_STORAGE}"
  storage_type               = "gp2"
  engine                     = "mysql"
  engine_version             = "5.7"
  instance_class             = "db.t2.micro"
  name                       = "${DB_NAME}"
  identifier                 = "${DB_NAME}"
  username                   = "${DB_USERNAME}"
  password                   = "${DB_PASS}"
  parameter_group_name       = "default.mysql5.7"
  db_subnet_group_name       = "${aws_db_subnet_group.fcc-acedirect-db-subnet-group.id}"
  auto_minor_version_upgrade = true
  port                       = "${DB_PORT}"
}
