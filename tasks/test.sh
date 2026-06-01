#!/bin/bash

poetry install --with test --no-root

echo "Running Ruff check..."
poetry run ruff check test/input.py --config ruff.toml || exit 1
echo ""

echo "Running Ruff check... (strict)"
(! poetry run ruff check test/input.py --config ruff-strict.toml) || exit 1
echo ""

echo "Running Ruff check with fixes..."
cp -R ./test/input.py ./test/result.py
poetry run ruff check test/result.py --fix --config ruff.toml
diff test/result.py test/expected_result_check.py || exit 1
echo ""

echo "Running Ruff check with fixes... (strict)"
cp -R ./test/input.py ./test/result.py
poetry run ruff check test/result.py --fix --config ruff-strict.toml
diff test/result.py test/expected_result_check_strict.py || exit 1
echo ""

echo "Running Ruff check with fixes... (strict, unsafe-fixes)"
cp -R ./test/input.py ./test/result.py
poetry run ruff check test/result.py --fix --unsafe-fixes --config ruff-strict.toml
diff test/result.py test/expected_result_check_strict_unsafe.py || exit 1
echo ""

echo "Running Ruff format..."
cp -R ./test/input.py ./test/result.py
poetry run ruff format test/result.py --config ruff.toml
diff test/result.py test/expected_result_format.py || exit 1
echo ""
