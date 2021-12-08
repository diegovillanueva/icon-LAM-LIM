# Get ICON repository

- Get access and repository from DWD (e.g., Insitute License @LIM)

# Grid information and external parameters

- Web for grid generation and external parameters 
	- [DWD Web Service](https://oflxd21.dwd.de/cgi-bin/spp1167/webservice.cgi)
		+ there is a general user and password available after request
+ Select desired grid resolution as RxxByy
    + Each Sub-domain has 4x the cell number
+ example:  [Example of 4 nested domains](examples/grid_dwd_web.pdf)

# Boundary condition data and initial condition data

+ install icon-tools
	- a compilation is sometimes included with the icon repository
	- [https://gitlab.dkrz.de/dwd-sw/dwd_icon_tools](https://gitlab.dkrz.de/dwd-sw/dwd_icon_tools)
+ download IFS data on ecaccess.ecmwf.int server (e.g., LIM access)
	- get access (e.g., Group of Johannes Quaas or Manfred Wendisch @ LIM)
	- access using: 
		- `ssh ecaccess.ecmwf.int`
	- download using:
		- [scripts/run_ifs4icon_bc.ksh](scripts/run_ifs4icon_bc.ksh ) (forecasts for boundary conditions)
		- [scripts/run_ifs4icon_init.ksh](scripts/run_ifs4icon_init.ksh ) (analyses for initial condition)
	- Although it takes longer, if no forecast are available, you can use analyses for the boundary conditions:
		- [scripts/run_ifs4icon_bc_ana.ksh](scripts/run_ifs4icon_bc_ana.ksh) (analyses)
	- send to your remote machine (e.g., MISTRAL) with:
		- `scp -r *.grb YourAccount@mistral.dkrz.de:/work/YourProject/YourAccount/`
+ regrid INITIAL conditions with (use sbatch)
    + [scripts/create_ic_ifs2icon_dv](scripts/create_ic_ifs2icon_dv)
+ regrid BOUNDARY conditions with (use sbatch)
    + [scripts/create_bc_ifs2icon_dv](scripts/create_bc_ifs2icon_dv)

# Configure the run to find the data

+ Use template for the EURECHA campaign:
    + [scripts/exp.icon_lam_1dom_EURECHA_1d.run](scripts/exp.icon_lam_1dom_EURECHA_1d.run)
+ Adapt the following variables:
	- grids_folder
	- init_data_path
		- and the following lines starting with "add_link_file"
	- latbc_boundary_grid, latbc_filename, latbc_path
	- start_date, end_date
+ A note about nesting:
	- every subdomain will have 4 times the cell number and the timestep will be halved.

# Run the model

- `cd PathToIcon/run/`
- `sbatch exp.icon_lam_1dom_EURECHA_1d.run`

# Regrid (use sbatch)

- [scripts/regrid_clm.sh](scripts/regrid_clm.sh)
- [scripts/grid_details.py](scripts/grid_details.py)

# Extras

- [scripts/bash_functions.sh](scripts/bash_functions.sh)

# More information

- TROPOS tutorial (need TROPOS vpn)
    - [https://tropos.gitlab-pages.dkrz.de/uni-master-module-t2/nbooks/01-Plotting-ICON-Topography.html](https://tropos.gitlab-pages.dkrz.de/uni-master-module-t2/nbooks/01-Plotting-ICON-Topography.html)
    - [https://gitea.tropos.de/Modelling/Workflow-Tutorials/src/branch/master/Tutorials/How_to_Access_Copernicus_ECMWF_data.md](https://gitea.tropos.de/Modelling/Workflow-Tutorials/src/branch/master/Tutorials/How_to_Access_Copernicus_ECMWF_data.md)
- MPI tutorial
    - [https://www.dwd.de/EN/ourservices/nwv_icon_tutorial/pdf_volume/icon_tutorial2020_en.pdf](https://www.dwd.de/EN/ourservices/nwv_icon_tutorial/pdf_volume/icon_tutorial2020_en.pdf)
- Quickstart guide
    - [https://wiki.mpimet.mpg.de/doku.php?id=models:pot-pourri:how_to:icon_quick_start_guide](https://wiki.mpimet.mpg.de/doku.php?id=models:pot-pourri:how_to:icon_quick_start_guide)
- ICON tools
    - [https://gitea.tropos.de/senf-docs/ICON-Documentation/src/branch/master/tutorials/Getting-Started-with-DWD-ICON-Tools.md](https://gitea.tropos.de/senf-docs/ICON-Documentation/src/branch/master/tutorials/Getting-Started-with-DWD-ICON-Tools.md)
    - [https://wiki.c2sm.ethz.ch/pub/MODELS/ICONDwdIconTools/doc_icontools.pdf](https://wiki.c2sm.ethz.ch/pub/MODELS/ICONDwdIconTools/doc_icontools.pdf)

