package model.record;

import java.util.List;

public interface RecordDao {
	void create(Record record);
	List<Record> readAll();
}
