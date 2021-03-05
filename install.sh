#!/usr/bin/env sh

BASEDIR="$(dirname "$0")"

set -eu
printf '\n'

function validate() {
	if [[ -n "$*" ]]; then
		printf '\n'
		if [[ "$1" != [YySsNn] ]]; then
			printf 'Invalid answer. Aborting...' >&2
			exit -1
		fi
	fi
}

function install() {
	local use_nvim
	# local use_starship
	local use_zsh
	local use_gitcfg
	local use_vifm

	read -r -p "This will overwrite files in your home directory. Do it anyway? (y/N/a) " -n 1 ans
	
	if [[ -z $ans ]] || [[ "$ans" = [Nn] ]] ; then
		printf 'Installation aborted.' >&2
		exit 1
	fi

	if ! [[ $ans = [YySsAaNn] ]]; then
		printf 'Please, enter a valid answer' >&2
		exit -1
	fi
	
	if [[ "$ans" = [Aa] ]] ; then
		use_nvim=1
		# use_starship=1
		use_zsh=1
		use_gitcfg=1
		use_vifm=1
	else
		printf '\n'
		read -r -p "Configure Neovim? (Y/n) " -n 1 ans
		validate $ans
		if [[ -z $ans ]] || [[ "$ans" = [YySs] ]] ; then
			use_nvim=1
		fi

		read -r -p "Configure Zsh? (Y/n) " -n 1 ans
		validate $ans
		if [[ -z $ans ]] || [[ "$ans" = [YySs] ]] ; then
			use_zsh=1
		fi

		# read -r -p "Configure Starship? (Y/n) " -n 1 ans
		# validate $ans
		# if [[ -z $ans ]] || [[ "$ans" = [YySs] ]] ; then
		#     use_starship=1
		# fi
        #
		read -r -p "Configure Git? (Y/n) " -n 1 ans
		validate $ans
		if [[ -z $ans ]] || [[ "$ans" = [YySs] ]] ; then
			use_gitcfg=1
		fi

		read -r -p "Configure Vifm? (Y/n) " -n 1 ans
		validate $ans
		if [[ -z $ans ]] || [[ "$ans" = [YySs] ]] ; then
			use_vifm=1
		fi

	fi

	if [[ $use_nvim == 1 ]]; then
		sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		cp -f $BASEDIR/vimrc $HOME/.config/nvim/init.vim
		cp -f $BASEDIR/ginit.vim $HOME/.config/nvim/ginit.vim
		cp -f $BASEDIR/config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
		cp -r $BASEDIR/vim/UltiSnips $HOME/.vim/
		# nvim --listen /tmp/nvim_pluginstall --headless -c ":PlugInstall" &
	fi

	if [[ $use_zsh == 1 ]]; then
		cp -f $BASEDIR/zshrc $HOME/.zshrc
		cp -f $BASEDIR/spaceship.zsh $HOME/.config/spaceship.zsh
		cp -f $BASEDIR/starship.toml $HOME/.config/starship.toml
		git clone https://github.com/zplug/zplug $HOME/.zplug
	fi

	# if [[ $use_starship == 1 ]]; then
		# cp -f $BASEDIR/spaceship.zsh $HOME/.config/spaceship.zsh
	# fi

	if [[ $use_gitcfg == 1 ]]; then
		cp -f $BASEDIR/gitconfig $HOME/.gitconfig
	fi

	if [[ $use_vifm == 1 ]]; then
		if ! [[ -d $HOME/.vifm ]]; then
			mkdir $HOME/.vifm
		fi
		cp -f $BASEDIR/vifm/vifmrc $HOME/.vifm/
	fi

	printf "Don't forget to run: \n"
	printf "git config --global user.email <email>\n"
	printf "git config --global user.name <name>\n"


}

install
echo ''

nvim --headless -c ":PluginInstall" & echo 'Done!\n'
