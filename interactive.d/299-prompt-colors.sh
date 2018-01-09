#!bash
COLORS_16=("0;33" "0;34" "0;35" "0;36" "1;32" "1;34" "1;35" "1;36")
COLORS_256=(3 4 5 6 10 12 13 14 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 99 100 101 102 103 104 105 106 107 108 109 110 111 112 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219)

# generate unique colors for user and host
user_hash=$(echo $USER | cksum | cut -c2-5)
host_hash=$(hostname -s | cksum | cut -c2-5)

if [[ $TERM =~ "256color" ]]; then
	user_index=$(($user_hash % ${#COLORS_256[@]}))
	host_index=$(($host_hash % ${#COLORS_256[@]}))
	USER_COLOR='\033[38;5;'${COLORS_256[${user_index}]}'m'
	HOST_COLOR='\033[38;5;'${COLORS_256[${host_index}]}'m'
else
	user_index=$(($user_hash % ${#COLORS_16[@]}))
	host_index=$(($host_hash % ${#COLORS_16[@]}))
	USER_COLOR='\033['${COLORS_16[${user_index}]}'m'
	HOST_COLOR='\033['${COLORS_16[${host_index}]}'m'
fi
