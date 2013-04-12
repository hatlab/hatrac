Book Format
-----------

* Dependencies should be together at the top of the file, one `(include-book ...)` call per line. Dependencies that use `:dir` will be ignored.
* Transitive dependencies are computed, so there's no need to re-include books that are included from books you already use.
* Documentation is indicated by lines that begin with `;;;;`. The first line is used as the title of the theorem and subsequent lines are a longer description, a la Python docstrings.
* Categories are specified by a line that starts with "Category: " and is followed by a valid category identifier (see here).

Example:

    (in-package "ACL2")

    (include-book "dep1")
    (include-book "dep2")

    ;;;; Name of Theorem
    ;;;; Description (this part can
    ;;;; span multiple lines)
    
    ;;;; Category: EQUALITY
    
    (defproperty append-associative
      ...)