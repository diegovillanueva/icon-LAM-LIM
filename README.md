
# Grid information and external parameters
    + Web for grid generation and extpar
        + <https://oflxd21.dwd.de/cgi-bin/spp1167/webservice.cgi>
            + user-id: icon-web
            + PW: icon@dwd
        + Select desired grid resolution as RxxByy
            + Each Sub-domain has 4x the cell number
        + example:  examples/grid_dwd_web.pdf


# 2) Boundary condition data and initial condition data
    + download ifs data on ecaccess.ecmwf.int server (LIM access)
        - /work/bb1114/b380602/icon-build/cloud-tracking-initial-data/{mars4icon_smi_new,run_ifs4icon_12_set.ksh}
    + regrid INITIAL conditions
        + /mnt/lustre02/work/bb1114/b380602/icon-build/icon-tools/dwd_icon_tools/example/runscripts/create_ic_ifs2icon_dv
    + regrid BOUNDARY conditions
        + /mnt/lustre02/work/bb1114/b380602/icon-build/icon-tools/dwd_icon_tools/example/runscripts/create_bc_ifs2icon_dv
    + run model with fabian config
        + /work/bb1114/b380602/icon-build/run/exp.icon_lam_1dom_lpz-emulation.run
            - grids_folder
            - init_data_path, add_link_file **
            - latbc_boundary_grid, latbc_filename, latbc_path
            - start_date, end_date
