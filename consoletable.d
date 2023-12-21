#!/usr/bin/env rdmd
import std.stdio;
import std.string;
import std.typecons;
import std.range;

class TableHeader
{
    ulong columnSize;
    string header;

    this(string header, Nullable!ulong columnSize)
    {
        ulong computedColumnsize = !columnSize.isNull ? columnSize.get : header.length;
        this.columnSize = computedColumnsize;
        this.header = header;
    }
}

class TableRow
{
    string[] data;

    this(string[] data)
    {
        this.data = data;
    }
}

void main()
{
    TableHeader[] headers = [
        new TableHeader("Name", cast(Nullable!ulong) 20),
        new TableHeader("Age", cast(Nullable!ulong) 3),
        new TableHeader("Address", cast(Nullable!ulong) 20),
        new TableHeader("City", cast(Nullable!ulong) 10),
        new TableHeader("State", cast(Nullable!ulong) 2),
        new TableHeader("Country", cast(Nullable!ulong) 2),
    ];

    TableRow[] rows = [
        new TableRow([
            "Sean Galland", "43", "123 Park Place", "Lytton", "CA", "US"
        ]),
        new TableRow([
            "Joshua Dominick Jones", "36", "3501 West Park Place", "Seattle", "WA",
            "US"
        ]),
        new TableRow([
            "Enrique Englesias Shapiro III", "26", "293 South Westville Ave",
            "San Franciso",
            "CA", "US"
        ])
    ];

    for (int header_index = 0; header_index < headers.length; header_index++)
    {
        TableHeader header = headers[header_index];
        write(header_index == 0 ? "| " : " | ");
        write(leftJustify(header.header, header.columnSize, ' '));
    }
    writeln(" |");

    for (int header_index = 0; header_index < headers.length; header_index++)
    {
        TableHeader header = headers[header_index];
        ulong repeatTimes = header.columnSize > header.header.length ? header.columnSize
            : header.header.length;
        write("| ", '-'.repeat(repeatTimes), ' ');
    }
    writeln("|");

    for (int row_index = 0; row_index < rows.length; row_index++)
    {
        TableRow row = rows[row_index];
        for (int column_index = 0; column_index < headers.length; column_index++)
        {
            TableHeader header = headers[column_index];

            string column_data = row.data[column_index];
            ulong trimToSize = header.columnSize < column_data.length ? header.columnSize
                : column_data.length;
            ulong columnSize = header.columnSize > header.header.length ? header.columnSize
                : header.header.length;
            write("| ", leftJustify(column_data[0 .. trimToSize], columnSize, ' '), ' ');
        }
        writeln("|");
    }

}
