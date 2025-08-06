import pandas as pd

def to_bin(val, bits):
    """Convert signed integer to binary string of given bit width."""
    if val < 0:
        val = (1 << bits) + val
    return format(val, f'0{bits}b')

# Load CSV file (make sure this path is correct)
df = pd.read_csv("mult_vectors.csv")  # Replace with your actual CSV path

# STIL header
header = '''STIL 1.0;

Signals {
    a : input;
    b : input;
    result : output;
    valid_out : output;
}

SignalGroups {
    inputs = a b;
    outputs = result valid_out;
}

WaveformTable "default" {
    Period '100ns';

    Waveform a { '0': L; '1': H; }
    Waveform b { '0': L; '1': H; }
    Waveform result { '0': L; '1': H; }
    Waveform valid_out { '0': L; '1': H; }
}

Patterns {
'''

# Build pattern section
patterns = ""
for i, row in df.iterrows():
    a_bin = to_bin(int(row["A"]), 32)
    b_bin = to_bin(int(row["B"]), 32)
    result_bin = to_bin(int(row["Result"]), 64)
    valid_bin = str(row["Valid"])

    patterns += f'''
    Pattern "PATTERN_{i+1}" {{
        WAVEFORM {{
            a = '{a_bin}';
            b = '{b_bin}';
            result = '{result_bin}';
            valid_out = '{valid_bin}';
        }}
    }}'''

# Close file
footer = "\n}"

# Write to .stil
with open("pipelined_multiplier_patterns_ate.stil", "w") as f:
    f.write(header + patterns + footer)

print("✅ STIL file generated: pipelined_multiplier_patterns_ate.stil")
