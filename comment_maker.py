
max_len = int(input("Enter the max line len: "))

print("Enter the text, ending with ENDCOMMENT on an empty line:")

text = ""

inp = input()
while inp != "ENDCOMMENT":
    text += inp + '\n'
    inp = input()

text = text.split('\n')[:-1]

print('*' * max_len)
ind = 0
while ind < len(text):
    words = text[ind].split(' ')

    line = ""
    for word_i in range(len(words)):
        if len(line) + len(words[word_i]) + 4 <= max_len:
            line += words[word_i] + " "
        else:
            break
        
    print("*", line[:-1] + " " * (max_len - len(line) - 3), "*")

    if word_i < len(words)-1:
        words = words[word_i:]
        text[ind] = ' '.join(word for word in words)
        ind -= 1
    ind += 1
print('*' * max_len)