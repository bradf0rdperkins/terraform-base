variable "AWS_REGION" {
  default = "us-west-2"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

#Security Groups
variable "ingress_web_ports_1" {
  default = [22, 443, 8080, 80, 8443, 5060, 3478, 5038, 8005, 3306, 8081]
}
variable "ingress_web_ports_2" {
  default = [3478, 5061, 3306, 5060]
}
variable "egress_web_ports_1" {
  default = [80, 8443, 443, 3478, 5038, 3306]
}
variable "egress_web_ports_2" {
  default = [3478, 443, 50561, 3306]
}
variable "protocols" {
  default = ["tcp", "udp"]
}

#Database
variable "DB_NAME" {
    default = ""
}
variable "DB_ALLOCATED_STORAGE" {
    default = 20
}
variable "DB_USERNAME" {
    default = ""
}
variable "DB_PASS" {
    default = ""
}
variable "DB_PORT" {
    default = 3306
}

#Instances
variable "AMIS" {
  type = map(string)
  default = {
    us-west-1 = "ami-"
    us-west-2 = "ami-"
    #us-east-1 = ""
  }
}

