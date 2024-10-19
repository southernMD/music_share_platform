package comY.myInterface;

import java.sql.ResultSet;
import java.sql.SQLException;


@FunctionalInterface
public interface ResultSetExtractor<T> {
    T extract(ResultSet rs) throws SQLException;
}