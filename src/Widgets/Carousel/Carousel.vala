/*
* Copyright (c) 2017 elementary LLC (https://elementary.io)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

public class AppCenter.Widgets.Carousel : Gtk.FlowBox {
    public signal void package_activated (AppCenterCore.Package package);

    public Carousel () {
        Object (activate_on_single_click : true,
                homogeneous: true);
    }

    construct {
        column_spacing = 12;
        row_spacing = 12;
        hexpand = true;
        selection_mode = Gtk.SelectionMode.NONE;
        child_activated.connect (on_child_activated);
    }

    public void add_package (AppCenterCore.Package? package) {
        var carousel_item = new CarouselItem (package);
        add (carousel_item);
        show_all ();
    }

    public void shuffle_packages(AppCenterCore.Package[] packages, int32 max) {
        get_children ().foreach ((c) => c.destroy ());
        Utils.shuffle_array (packages);

        if (packages.length != 0) {
            Idle.add (() => {
                for (int i = 0; i < max && i < packages.length; i++) {
                    add_package (packages[i]);
                }
                return false;
            });
        }
    }

    private void on_child_activated (Gtk.FlowBoxChild child) {
        if (child is Widgets.CarouselItem) {
            var package = ((Widgets.CarouselItem)child).package;
            package_activated (package);
        }
    }
}
