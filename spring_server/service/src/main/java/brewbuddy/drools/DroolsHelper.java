package brewbuddy.drools;

import org.kie.api.runtime.ClassObjectFilter;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.FactHandle;

import java.util.Collection;

public class DroolsHelper {
    public static void clearObjectsFromSession(KieSession kieSession, Class<?> clazz) {
        Collection<?> objects = kieSession.getObjects(new ClassObjectFilter(clazz));

        for (Object object : objects) {
            FactHandle handle = kieSession.getFactHandle(object);
            if (handle != null) {
                kieSession.delete(handle);
            }
        }
    }
}