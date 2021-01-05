class Jcliff < Formula
  desc "Manage JBossAS 7/EAP6/EAP7/Wildfly with modular configuration files"
  homepage "https://github.com/bserdar/jcliff"
  url "https://github.com/bserdar/jcliff/releases/download/v2.12.7/jcliff-2.12.7-dist.tar.gz"
  sha256 "e82154cf5a95535189db4f973a8cbbf04d8919fe2a8e5814ed14f0980b0901d3"

  bottle :unneeded

  depends_on "openjdk" => :optional

  def install
    libexec.install Dir["rules", "*.jar"]

    (libexec).install "jcliff"
    (bin/"jcliff").write_env_script("#{libexec}/jcliff", :JCLIFF_HOME => libexec.to_s)
    chmod 0755, libexec/"jcliff"
  end

  def caveats
    <<~EOS
      Jcliff installed! Before use, the JBOSS_HOME environment variable must be set, similar to the following:
        export JBOSS_HOME=<Location of JBoss Server>
    EOS
  end

  test do
    ENV["JBOSS_HOME"] = opt_libexec
    assert_match "Jcliff version #{version}", shell_output("#{bin}/jcliff -v", 3).chomp
  end
end
