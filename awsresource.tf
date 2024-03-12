# Create AWS Instance
resource "aws_instance" "cloud_security_lab6" {
  ami           = "ami-0f403e3180720dd7e" 
  instance_type = "t2.micro"
  tags = {
    Name        = "Cloud Security Instance"
    Environment = "Production"
    Owner       = "Shreya bhoir"
  }

  # Associate IAM Instance Profile
  iam_instance_profile = aws_iam_instance_profile.my_instance_profile.name
}


# Create AWS Instance Profile
resource "aws_iam_instance_profile" "my_instance_profile" {
  name  = "my-instance-profile"
  role  = aws_iam_role.shreya_role.name
}