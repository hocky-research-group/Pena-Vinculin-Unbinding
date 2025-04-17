#apo
set n_actin_res 375
set n_actin 5
set chain_list { A B C D E }
set total_n_actin_res [expr $n_actin_res*$n_actin]

#set gro_file "/scratch/projects/hockygroup-archive/wpc252/projects/factin_vinculin/apo/setup/eq/npt.gro"
#set outpdb "apo_actin_vinculin_labeled.pdb"
#set outpsf "apo_actin_vinculin_labeled.psf"
#
#set gro_file "/scratch/projects/hockygroup-archive/wpc252/projects/factin_vinculin/holo/setup/eq/npt.gro"
#set outpdb "holo_actin_vinculin_labeled.pdb"
#set outpsf "holo_actin_vinculin_labeled.psf"
#
#set gro_file "/scratch/projects/hockygroup-archive/wpc252/projects/factin_vinculin/apo/fes/actin_apoVinc_opes_pullProj_free_gpu_pn_-10.0/1/1_fes_pullVt.run.25000000.gro"
#set outpdb "apo_actin_vinculin_fes_labeled.pdb"
#set outpsf "apo_actin_vinculin_fes_labeled.psf"

set gro_file "/scratch/projects/hockygroup-archive/wpc252/projects/factin_vinculin/holo/fes/actin_holoVinc_opes_pullProj_free_gpu_pn_20.0/1/1_fes_pullVt.run.25000000.part0002.gro"
set outpdb "holo_actin_vinculin_fes_labeled.pdb"
set outpsf "holo_actin_vinculin_fes_labeled.psf"

mol new $gro_file waitfor all

set sa [ atomselect top "all"]
$sa set segname X
$sa set chain X

set protein_sel [atomselect top "protein and name CA"]
set protein_residues [$protein_sel get residue]

for {set i 0} {$i < $n_actin} {incr i} {
	set first_res_idx [expr $i*$n_actin_res ]
	set last_res_idx [expr [expr $i+1]*$n_actin_res -1]

	set first_res [lindex $protein_residues $first_res_idx]
	set last_res [lindex $protein_residues $last_res_idx]
	puts "$first_res $last_res"

	set sel [atomselect top "protein and residue $first_res to $last_res"]
	$sel set segname A[expr $i+1]
	$sel set chain [lindex $chain_list $i ]
}

set first_vinc [ lindex $protein_residues [expr $last_res_idx + 1] ]
set last_vinc [ lindex $protein_residues end]
set vinc [atomselect top "protein and residue $first_vinc to $last_vinc"]
$vinc set segname V
$vinc set chain V


set sel [atomselect top all]
$sel writepdb $outpdb
$sel writepsf $outpsf
exit




