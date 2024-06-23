
resource "aws_key_pair" "flask1" {
  key_name   = "flask-key"
  public_key = file("~/.ssh/flask.pub")
}


