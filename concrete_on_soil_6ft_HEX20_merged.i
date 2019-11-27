[Mesh]
  type = FileMesh
  file = concrete_on_soil_6ft_HEX20_merged.e
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
    order = SECOND
  [../]
  [./disp_y]
    order = SECOND
  [../]
  [./disp_z]
    order = SECOND
  [../]
[]

[AuxVariables]
  [./vel_x]
    order = SECOND
  [../]
  [./accel_x]
    order = SECOND
  [../]
  [./vel_y]
    order = SECOND
  [../]
  [./accel_y]
    order = SECOND
  [../]
  [./vel_z]
    order = SECOND
  [../]
  [./accel_z]
    order = SECOND
  [../]
   [./stress_xx]
    order = FIRST
    family = MONOMIAL
  [../]
 [./stress_yy]
    order = FIRST
    family = MONOMIAL
  [../]
 [./stress_zz]
    order = FIRST
    family = MONOMIAL
  [../]
 [./stress_xy]
    order = FIRST
    family = MONOMIAL
  [../]
 [./stress_yz]
    order = FIRST
    family = MONOMIAL
  [../]
 [./stress_xz]
    order = FIRST
    family = MONOMIAL
  [../]
 [./vonmises]
    order = FIRST
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./DynamicTensorMechanics]
    static_initialization = true
#    use_displaced_mesh = true
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./gravity]
    type = Gravity
    variable = disp_z
    value = -32.17
  [../]
  [./inertia_x]
    type = InertialForce
    variable = disp_x
    velocity = vel_x
    acceleration = accel_x
    beta = 0.25
    gamma = 0.5
    eta=0.0
  [../]
  [./inertia_y]
    type = InertialForce
    variable = disp_y
    velocity = vel_y
    acceleration = accel_y
    beta = 0.25
    gamma = 0.5
    eta=0.0
  [../]
  [./inertia_z]
    type = InertialForce
    variable = disp_z
    velocity = vel_z
    acceleration = accel_z
    beta = 0.25
    gamma = 0.5
    eta = 0.0
  [../]
[]

[AuxKernels]
  [./accel_x]
    type = NewmarkAccelAux
    variable = accel_x
    displacement = disp_x
    velocity = vel_x
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_x]
    type = NewmarkVelAux
    variable = vel_x
    acceleration = accel_x
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_y]
    type = NewmarkAccelAux
    variable = accel_y
    displacement = disp_y
    velocity = vel_y
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_y]
    type = NewmarkVelAux
    variable = vel_y
    acceleration = accel_y
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./accel_z]
    type = NewmarkAccelAux
    variable = accel_z
    displacement = disp_z
    velocity = vel_z
    beta = 0.25
    execute_on = timestep_end
  [../]
  [./vel_z]
    type = NewmarkVelAux
    variable = vel_z
    acceleration = accel_z
    gamma = 0.5
    execute_on = timestep_end
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
  [../]
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy
    index_i = 0
    index_j = 1
  [../]
  [./stress_yz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yz
    index_i = 1
    index_j = 2
  [../]
  [./stress_xz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xz
    index_i = 0
    index_j = 2
  [../]
  [./vonmises]
    type = RankTwoScalarAux
    rank_two_tensor = stress
    variable = vonmises
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
[]


[BCs]
  [./fix_y_soil_bottomleft]
    type = PresetBC
    variable = disp_y
    boundary = 1000
    value = 0.0
  [../]
  [./fix_x_soil_bottomleft]
    type = PresetBC
    variable = disp_x
    boundary = 1000
    value = 0.0
  [../]
  [./fix_y_soil_bottomright]
    type = PresetBC
    variable = disp_y
    boundary = 1001
    value = 0.0
  [../]
  [./fix_z_soil_bottom]
    type = PresetBC
    variable = disp_z
    boundary = 100
    value = 0.0
  [../] 
 [./SeismicForce]
    [./bottomx]
      displacements = 'disp_x disp_y disp_z'
      input_components = '0'
      boundary = 100
      velocity_functions = 'velx_bottom' # input velocity functions
          shear_wave_speed = 3718.22
         p_wave_speed = 6956.2
      density = 0.00494
  [../]
[../]

# [./SeismicForce]
#    [./bottomy]
#      displacements = 'disp_x disp_y disp_z'
#      input_components = '1'
#      boundary = 100
#      velocity_functions = 'vely_bottom' # input velocity functions
#          shear_wave_speed = 3718.22
#         p_wave_speed = 6956.2
#      density = 0.00494
#  [../]
#[../]
# [./SeismicForce]
#    [./bottomz]
#      displacements = 'disp_x disp_y disp_z'
#      input_components = '2'
#      boundary = 100
#      velocity_functions = 'velz_bottom' # input velocity functions
#          shear_wave_speed = 3718.22
#         p_wave_speed = 6956.2
#      density = 0.00494
#  [../]
#[../]

  [./NonReflectingBC]
    [./back]
     displacements = 'disp_x disp_y disp_z'
     velocities = 'vel_x vel_y vel_z'
     accelerations = 'accel_x accel_y accel_z'
     beta = 0.25
     gamma = 0.5
     boundary = 100
     shear_wave_speed = 7161.5
     p_wave_speed = 6956.2
     density = 0.00494
   [../]
 [../]
 [./Periodic]
   [./y_dir]
     variable = 'disp_x disp_y disp_z'
     primary = '101'
     secondary = '103'
     translation = '0 18 0'
   [../]
   [./x_dir]
     variable = 'disp_x disp_y disp_z'
     primary = '102'
     secondary = '104'
     translation = '18 0 0'
   [../]
 [../]
[]

[Functions]
[./velx_bottom]
     type = PiecewiseLinear
     data_file = inputx3_from_0.025.csv
     format = 'columns'
  [../]
#[./vely_bottom]
#     type = PiecewiseLinear
#     data_file = inputy3_from_0.025.csv
#     format = 'columns'
#  [../]
#[./velz_bottom]
#     type = PiecewiseLinear
#     data_file = inputz3_from_0.025.csv
#     format = 'columns'
#  [../]
[]

[Materials]
  [./elasticity_tensor_block]
    youngs_modulus = 5.76e5 #kip/ft^2
    poissons_ratio = 0.25
    type = ComputeIsotropicElasticityTensor
    block = 2
  [../]
  [./strain_block]
    type = ComputeSmallStrain
    block = 2
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress_block]
    type = ComputeLinearElasticStress
    block = 2
  [../]
  [./den_block]
    type = GenericConstantMaterial
    block = 2
    prop_names = density
    prop_values = 4.6615e-3 #kip s^2/ft ^4
  [../]
  [./elasticity_tensor_soil]
    youngs_modulus = 2.0136e4 #kip/ft^2
    poissons_ratio = 0.3
    type = ComputeIsotropicElasticityTensor
    block = 1
  [../]
  [./strain_soil]
    type = ComputeSmallStrain
    block = 1
    displacements = 'disp_x disp_y disp_z'
  [../]
  [./stress_soil]
    type = ComputeLinearElasticStress
    block = 1
  [../]
  [./den_soil]
    type = GenericConstantMaterial
    block = 1
    prop_names = density
    prop_values = 2.812e-3 #kip s^2/ft^4
  [../]
[]

[Preconditioning]
  [./andy]
    type = SMP
    full = true
  [../]
[]


[Postprocessors]
[]

#[VectorPostprocessors]
#  [./accel_hist]
#    type = ResponseHistoryBuilder
#    variables = 'accel_x accel_y'
#    nodes = '2167 141 699'
#  [../]
#  [./accel_spec]
#    type = ResponseSpectraCalculator
#    vectorpostprocessor = accel_hist
#    regularize_dt = 0.00125
#    outputs = response_spectra
#  [../]
#[]

[Controls]
  [./inertia_switch]
    type = TimePeriod
    start_time = 0
    end_time = 0.00125
    enable_objects = 'BCs::fix_y_soil_bottomleft BCs::fix_x_soil_bottomleft BCs::fix_y_soil_bottomright'
    disable_objects = '*/inertia_x */inertia_y */inertia_z */vel_x */vel_y */vel_z */accel_x */accel_y */accel_z'
    set_sync_times = true
  [../]
[]


[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu     superlu_dist'
#  petsc_options = '-snes_ksp_ew'
#  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
#  petsc_options_value = '201                hypre    boomeramg      4'
  line_search = 'none'
  start_time = 0
  end_time = 1
  dt = 0.00125
  dtmin = 2.5e-4
  nl_abs_tol = 1e-1
  nl_rel_tol = 1e-4
  l_tol = 1e-2
  l_max_its = 20
  timestep_tolerance = 1e-6
  [./Quadrature]
    order = THIRD
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
  print_linear_residuals = false
#  [./response_spectra]
#    type = CSV
#    execute_on = 'final'
#  [../]
  [./screen]
    type = Console
    max_rows = 1
  [../]
[]
