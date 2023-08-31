<div align="center">
	<h1>⚙️ NixOS Configuration</h1>
	<img width="400" src="https://github.com/pweth/dotfiles/assets/22416843/bf22ddd3-bfb0-47a1-bd60-b46be7568bbd">
</div>

---

## Structure

<table>
	<tr>
		<td colspan="2"><b>assets/</b></td>
	</tr>
	<tr>
		<td>background.jpg</td>
		<td>Desktop background image</td>
	</tr>
	<tr>
		<td>bashrc</td>
		<td><code>~/.bashrc</code> shell script</td>
	</tr>
	<tr>
		<td>newsflash.json</td>
		<td><a href="https://gitlab.com/news-flash/news_flash_gtk">NewsFlash</a> configuration</td>
	</tr>
	<tr>
		<td>profile.png</td>
		<td>GNOME profile image</td>
	</tr>
	<tr>
		<td colspan="2"><b>home/</b></td>
	</tr>
	<tr>
		<td>default.nix</td>
		<td>General <a href="https://github.com/nix-community/home-manager">Home Manager</a> configuration</td>
	</tr>
	<tr>
		<td>{program}.nix</td>
		<td>Program-specific Home Manager configurations</td>
	</tr>
	<tr>
		<td colspan="2"><b>hosts/{host}/</b></td>
	</tr>
	<tr>
		<td>default.nix</td>
		<td>General system configuration</td>
	</tr>
	<tr>
		<td>hardware-configuration.nix</td>
		<td>Hardware system configuration</td>
	</tr>
	<tr>
		<td colspan="2"><b>secrets/</b></td>
	</tr>
	<tr>
		<td>secrets.nix</td>
		<td><a href="https://github.com/ryantm/agenix">agenix</a> encryption configuration</td>
	</tr>
	<tr>
		<td>{secret}.age</td>
		<td>Secret age-encrypted files</td>
	</tr>
</table>
