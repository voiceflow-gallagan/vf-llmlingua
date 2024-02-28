import json
import sys

from llmlingua import PromptCompressor

# Parse the arguments
args = json.loads(sys.argv[1])

# Setup LLMLingua
llm_lingua = PromptCompressor(device_map='auto')

# 6x Compression
compressed_prompt = llm_lingua.compress_prompt(
    args['context'].split("\n"),
    instruction=args['instruction'],
    question=args['question'],
    target_token=500,
    condition_compare=True,
    condition_in_question="after",
    rank_method="longllmlingua",
    use_sentence_level_filter=False,
    context_budget="+100",
    dynamic_context_compression_ratio=0.4,  # enable dynamic_context_compression_ratio
    reorder_context="sort",
)
message = [
    {"role": "user", "content": compressed_prompt["compressed_prompt"]},
]

print(json.dumps(compressed_prompt, indent=4))
