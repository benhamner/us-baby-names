.separator ","

CREATE TABLE NationalNames (
    Id INTEGER PRIMARY KEY,
    Name TEXT,
    Year INTEGER,
    Gender TEXT,
    Count INTEGER);

CREATE TABLE StateNames (
    Id INTEGER PRIMARY KEY,
    Name TEXT,
    Year INTEGER,
    Gender TEXT,
    State TEXT,
    Count INTEGER);

.import "working/noHeader/NationalNames.csv" NationalNames
.import "working/noHeader/StateNames.csv" StateNames

CREATE INDEX nationalnames_name_idx ON NationalNames (Name);
CREATE INDEX nationalnames_year_idx ON NationalNames (Year);
CREATE INDEX statenames_name_idx  ON StateNames (Name);
CREATE INDEX statenames_year_idx  ON StateNames (Year);
CREATE INDEX statenames_state_idx ON StateNames (State);
