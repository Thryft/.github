set -e

GITHUB_USERNAME=$1
GITHUB_PASSWORD=$2

TMUX_CONAINER_NAME="worker_scraper_consume_from_queue_mode"

# Check for arguments
if [[ $# -lt 1 ]] ; then
	echo '[ERROR] You must supply a GITHUB_USERNAME to pull'
	exit 1
fi

if [[ $# -lt 2 ]] ; then
	echo '[ERROR] You must supply a GITHUB_PASSWORD to pull'
	exit 1
fi

# Pull github repo.
echo "Pulling github repo."
cd /root/worker_scraper
git pull https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/mrnewguy/worker_scraper.git

# cd back to root
cd

# Install requirements
pip3 install -r worker_scraper/requirements.txt

# Set python path
export PYTHONPATH='/root/worker_scraper'

# Destroy current running tmux container.
echo "Killing current running tmux container."
tmux kill-session -t worker_scraper_consume_from_queue_mode

echo "Creating new tmux container."
# Create new worker and run app
tmux new-session -d -s worker_scraper_consume_from_queue_mode 'python3 worker_scraper/app/main_app.py'