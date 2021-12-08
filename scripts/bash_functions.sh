replaceDo()
{
    f=$3
    comm="s/"$1"/"$2"/gi";
    sed -i -E "$comm" "$f"
}

quickrerun_icon() {
	run_file=$1
	vi $run_file
	sbatch $run_file
}

quicknewrun_icon() { 
	oldrun_file=exp.EXPERIMENT1.run
	oldrun_file=$1
	oldrun_name=${oldrun_file/exp./}
	oldrun_name=${oldrun_name/.run/}

	newrun_file=exp.EXPERIMENT2.run
	newrun_file=$2
	newrun_name=${newrun_file/exp./}
	newrun_name=${newrun_name/.run/}

	/bin/cp -av $oldrun_file $newrun_file
	replaceDo $oldrun_name $newrun_name $newrun_file

	quickrerun_icon $2	
}

function cherrn {
	    nl=$1 ; shift 1
            greprn $nl $@ -ni -e fault -e error -e found -e failed -e abort -e invalid -e fatal
}
#check errors in log file
cherr() { cherrn 0 $@ ; }
