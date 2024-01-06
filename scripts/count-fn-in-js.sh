#!/bin/bash

# Declare an associative array to hold line number -> function names
declare -A arr
# Declare a regular array to hold function names and line counts together as a tuple
declare -a arr2

# Get the line numbers of all functions in the JavaScript file
# both async, and regular function is searched, not supported arrow function right now.
function_start_lines=$(awk '/^(async[[:space:]]+)?function[[:space:]]+/ { 
    match($0, /function[[:space:]]+([a-zA-Z0-9_]+)/);
    print NR, substr($0, RSTART, RLENGTH);
}' $1)

# Loop through each function and find the ending line number
while read -r start_line function_name; do
	# Find the ending line number by searching for the next line with only '}'
	# should have used a stack, and push a parenthesis when we encounter open, and pop when we encounter a close parenthesis
	# if the len of the stack is 0 again, that line should have the ending line of function
	# but here we are assuming that, } is the only character in the line, and it is in the first position, then we are having an ending of a function
	end_line=$(awk "NR > $start_line && /^}$/ { print NR; exit }" $1)

	if [ -n "$end_line" ]; then
		diff=$((end_line - $start_line + 1))
		f_n=($function_name)
		# that ending , ah cringe!, ideally we should have joined this
		arr["$diff"]+="${f_n[1]},"
		arr2+=("${f_n[1]}:$diff")
		echo "${f_n[1]} $start_line $end_line"
	else
		echo "Error: Could not find the ending '}' for function starting at line $start_line"
	fi
done <<<"$function_start_lines"

echo "----------------------------"
for key in ${!arr[@]}; do
	echo "$key: ${arr[$key]}"
done
echo "################"
# Sort arr2 by line count in descending order
IFS=$'\n' sorted_arr2=($(sort -t':' -k2,2nr <<<"${arr2[*]}"))
unset IFS

for entry in "${sorted_arr2[@]}"; do
	IFS=':' read -r f_name lines <<<"$entry"
	echo "$f_name: $lines"
done
