#### Usage
- run `bundle install` before using
- after installing the dependencies, run `ruby lib/main.rb`

#### Inside the program

## Basic commands
Available commands are:
- `set key val` - Sets a value to a specific key
- `get key` - Fetches value assigned to key, if any.
- `unset key` - Removes key entry, if any.
- `numequalto value` - Counts the appearances of a specific value.

## Transactions
To start a transaction, run `begin`. Basic commands are available within a transaction.
Once you are satisfied with your transaction, `commit` to persist it.
If you wish to erase the current transaction, `rollback`.

E.g.

``` ruby
set linus torvalds
set simon peyton
set paul hudak
begin
set andrew tanenbaum
set yukihiro matsumoto
numequalto torvalds #=> 1
numequalto tanenbaum #=> 1
commit
```


