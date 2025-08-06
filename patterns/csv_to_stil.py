
import pandas as pd

def to_bin(val, bits):
    """Convert signed integer to binary string of given bit width."""
    if val < 0:
        val = (1 << bits) + val
    return format(val, f'0{bits}b')

# Load from CSV
df = pd.read_csv("mult_vectors.csv")  # replace with your path

# Header
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

# Patterns
patterns = ""
for i, row in df.iterrows():
    a_bin = to_bin(int(row["A"]), 32)
    b_bin = to_bin(int(row["B"]), 32)
    result_bin = to_bin(int(row["Result"]), 64)
    valid_bin = str(row["Valid"])

    patterns += f'''
 ​:contentReference[oaicite:0]{index=0}​
