package model.register;

import java.util.List;

public interface RegisterDao {
		void create(Register register);
		List<Register> readAll();
}
