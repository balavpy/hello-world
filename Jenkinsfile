pipeline {
  agent any
  steps {
    build("test build")
    {
      step{
          sh  'mvn clean install package'
      }
    }

  }
}
