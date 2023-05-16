"""Module containing the tests for the default scenario."""

# Standard Python Libraries
import os

# Third-Party Libraries
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ["MOLECULE_INVENTORY_FILE"]
).get_hosts("all")


def test_falcon_sensor_installed(host):
    """Test that the CrowdStrike Falcon sensor was installed."""
    dir_full_path = "/opt/CrowdStrike"
    directory = host.file(dir_full_path)
    assert directory.exists
    assert directory.is_directory
    # Make sure that the directory is not empty
    assert host.run_expect([0], f'[ -n "$(ls -A {dir_full_path})" ]')


def test_falcon_sensor_enabled(host):
    """Test that the CrowdStrike Falcon sensor is enabled."""
    svc = host.service("falcon-sensor")
    assert svc.is_enabled
