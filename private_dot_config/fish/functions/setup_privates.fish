
function setup_privates
    if [ ! -f ~/playbooks/ansible-password ]
        cd ~/playbooks/
        echo "Enter your ansible vault password"
        read -s password
        echo $password > ansible-password
        chmod 600 ansible-password
        echo "Ansible-password file created"
    end

    cd ~/playbooks/
    ansible-playbook privates.yaml
end
