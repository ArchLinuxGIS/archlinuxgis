# vim:sts=2:sw=2:ft=ruby

CHROOTS = {
  'i686' => "/mnt/chroot/i686",
  'x86_64' => '/mnt/chroot/x86_64'
}

class Build < Thor
  include Thor::Actions
  default_task :all

  desc "all", "Rigenera tutti i pacchetti."
  def all
    invoke :i686
    invoke :x86_64
  end

  desc 'i686', 'Rigenera il pacchetto per i686.'
  def i686
    @chroot = CHROOTS['i686']

    # Aggiorno la chroot, quindi buildo il pacchetto.
    run %[sudo linux32 makechrootpkg -c -r #{@chroot} -u -n]
  end

  desc 'x86_64', 'Rigenera il pacchetto per x86_64.'
  def x86_64
    @chroot = CHROOTS['x86_64']

    # Aggiorno la chroot, quindi buildo il pacchetto.
    run %[sudo makechrootpkg -c -r #{@chroot} -u -n]
  end

  desc 'update_all', "Aggiorna tutti i chroot."
  def update_all
    invoke :update_i686
    invoke :update_x86_64
  end

  desc 'update_i686', "Aggiorno il chroot i686."
  def update_i686
    @chroot = CHROOTS['i686']

    run %[sudo linux32 mkarchroot -u #{@chroot}/root]
  end

  desc 'update_x86_64', "Aggiorno il chroot x86_64."
  def update_x86_64
    @chroot = CHROOTS['x86_64']

    run %[sudo mkarchroot -u #{@chroot}/root]
  end

end
