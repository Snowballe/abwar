package com.example.abwar;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.content.ContentValues;


public class DBHandler extends SQLiteOpenHelper {
    private static final String DB_NAME="AbwarDB";
    private static final int DB_VERSION=1;
    private static final String TABLE_NAME ="QUESTIONS";
    private static final String ID_COL="id";
    private static final String NAME_COL="Question";

    public DBHandler(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }


@Override
public void onCreate(SQLiteDatabase db){
    String q="CREATE TABLE " + TABLE_NAME +" ("
            + ID_COL+" integer primary key autoincrement, "
            + NAME_COL+"TEXT)";
    db.execSQL(q);
}

public void addQuestion(String Question){
    SQLiteDatabase db = DBHandler.this.getWritableDatabase();
    ContentValues values = new ContentValues();

    values.put(NAME_COL, Question);
    db.insert(TABLE_NAME,null,values);
    db.close();

}
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // this method is called to check if the table exists already.
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }
}