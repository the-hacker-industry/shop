namespace Utils {
    public void shuffle_array<T> (T[] array) {
        var rand = new GLib.Rand ();
        for (int i = 0; i < array.length * 3; i++) {
            swap (&array[0], &array[rand.int_range(1, array.length-1)]);
        }
    }

    public void swap<T> (T *x, T *y) {
        var tmp = *x;
        *x = *y;
        *y = tmp;
    }
}
