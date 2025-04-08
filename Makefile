diff:
	git add .
	git diff --cached > ~/diff
	echo -n "Lines: " && wc -l ~/diff

push:
	git add .
	git commit -F ~/commit.txt
	git push origin HEAD
	git checkout main

push_branch:
	git add .
	git commit -F ~/commit.txt
	git push origin HEAD

rebuild:
	flutter clean
	flutter pub get

test_coverage:
	flutter test --coverage