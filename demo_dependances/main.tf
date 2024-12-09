resource "null_resource" "resource1" {
  attribute_ressource1 = "value of attribute ressource 1" 
}

resource "null_resource" "resource2" {
  attribute_ressource2 = null_resource.resource1.attribute_ressource1
}

resource "null_resource" "resource3" {
  
}


resource "null_resource" "resource4" {
  
}


resource "null_resource" "resource5" {
  depends_on = [ null_resource.resource3, null_resource.resource4 ]
}

resource "null_resource" "resource6" {
    attribute1 = "new val of attribute 1"
    attribute2 = "val of attribute 2"
    lifecycle {
      ignore_changes = [ attribute1 ]
    }
}
