
# https://cloud.google.com/solutions/jenkins-on-container-engine-tutorial

gcloud compute images create jenkins-home-image --source-uri https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v3.tar.gz
gcloud compute disks create jenkins-home --image jenkins-home-image 
kubectl create ns jenkins
