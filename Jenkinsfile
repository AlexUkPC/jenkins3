pipeline {
    agent {
        label 'ssh'  
    }
    parameters {
        string(name: 'REF', defaultValue: '\${ghprbActualCommit}', description: 'Commit to build')
    }
    stages {
        stage('Webpacker Install') {
            steps {
                sh '/usr/local/bin/docker-compose run --rm web_jenkins3 bin/rails webpacker:install'
            }
        }
        stage('Build') {
            steps {
                sh '/usr/local/bin/docker-compose stop'
                sh '/usr/local/bin/docker-compose up -d'
                sh '/usr/local/bin/docker-compose exec -T --user "$(id -u):$(id -g)" web_jenkins3 bin/rails db:create'
                sh '/usr/local/bin/docker-compose exec -T --user "$(id -u):$(id -g)" web_jenkins3 bin/rails db:migrate'
                timeout(120) {
                    waitUntil {
                        script {
                            try {
                                def response = httpRequest 'http://0.0.0.0:3031'
                                return (response.status == 200)
                            }
                            catch (exception) {
                                return false
                            }
                        }
                    }
                }
            }
        }
        stage('test') {
            steps {
                sh '/usr/local/bin/docker-compose exec -T --user "$(id -u):$(id -g)" web_jenkins3 jenkins3/bin/rails test:models'
            }   
        } 
    }
}